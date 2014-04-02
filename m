Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Removing GAttrib.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25TeYWXMxQPqBGd9YnNWw+y5sYT+k4e-88hu_SRtFYWY+g@mail.gmail.com>
Date: Wed, 2 Apr 2014 14:39:25 -0700
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <B767FC90-10FE-41A1-8607-90F8D3F18BD1@holtmann.org>
References: <CAHrH25QBL52xfM4Qnk=NE1xn3RX2Bwxq_i0osDDCoi4egO2tkg@mail.gmail.com> <CAKT1EBfqP75+XJWkLt2yvkdEBVmNRmFC1_T667LAnuBrNFBxuQ@mail.gmail.com> <CAHrH25TeYWXMxQPqBGd9YnNWw+y5sYT+k4e-88hu_SRtFYWY+g@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> Remove GAttrib completely from the source will not be easy. You could
>> try to restrict the usage of GAttrib to src/gatt.c
>> Move discovery to src/gatt.c introduces another problem: probe
>> profiles/services, reply properly for Pair() and ConnectProfiles(),
>> helpers to access attributes of a given service, ...
> 
> My understanding of the ConnectProfile() D-Bus method was that it
> pretty much only applies to BR/EDR. Even with GATT over BR/EDR I don't
> know if this method makes sense as connecting to a specific remote
> profile is not something you would do in LE. You would instead read
> several GATT services and interact with all of them based on the
> profile you're implementing. Maybe we can add D-Bus methods to
> interact with specific GATT service UUIDs in the future but I don't
> know if ConnectProfile fits into the overall BLE scheme, though please
> correct me if I'm wrong.

at the moment ConnectProfile() is BR/EDR specific and it most likely will stay way. So for LE only devices it should just return an error at the moment.

> As for the reply to pairing, I don't think much would change. The only
> reason for moving discovery to src/gatt.c is to restrict usage of
> GAttrib to src/gatt.c. In effect, what we would do is add a function,
> e.g. btd_gatt_discover_primary, which would be, from the perspective
> of src/device.c, a thin wrapper around gatt_discover_primary. Instead
> of directly storing a list of gatt_primary, btd_device would now store
> a list of btd_attribute (or handle) of its primary services. Initially
> we would leave probing the way it is but we would have the profiles
> use new functions in src/gatt to access characteristics and
> descriptors, instead of using GAttrib directly.
> 
> As for the auto-connect case, whether or not we want to re-discover
> all GATT services is something that I'm not sure about. We can always
> think about this later, though.

We want to use Service Changed notification and do a selective re-discover to avoid the extra overhead that a full discovery might cause. It does not have to be done in the beginning, but that is where this should be heading towards.

>> Probably, we will not be able to remote ATTIO immediately. ATTIO
>> abstraction will be replaced by mgmt commands proposed by "[RFC] doc:
>> Connection Parameters Command". Keep re-connections working with old
>> kernels will be tricky.
> 
> Probably not. We can, however, try to at least remove the GAttrib
> dependency from attio. With new discovery accessors in src/gatt, the
> GAttrib pointer in attio_connect_cb would become unnecessary.
> 
>> My suggestion is start with small cleanups & improvements, as you
>> probably noticed the code related to BLE & GATT is not easy to
>> understand.
>> 
>> My understanding was GIOChannel usage is not encouraged anymore, we
>> should use "struct io" instead. So, replace GIOChannel  by struct io
>> could be a good starting point.
>> (please confirm with Johan)
> 
> Afaict the primary piece of code concerning attribute discovery that
> uses GIOChannel consists of the bt_io functions in btio/btio.*. If
> Johan agrees, we could start by replacing GIOChannel with struct io in
> btio/btio. Once we do this, we would make GAttrib use struct io
> instead of GIOChannel as the initial step of the refactor. Let me know
> if this is a good approach.

When we are talking about ATT and struct io, I get the feeling we should not even involve btio at all. Especially for the LE only version we are running on L2CAP fixed channel.

The attribute protocol should just run over a file descriptor. Whatever this file descriptor might be. Then the ATT handling needs to wrap this file descriptor into struct io. Similar to how I have done this for src/shared/mgmt.c.

Some time back I started look into writing src/shared/att.c that really is suppose to be dead simple and just treats ATT protocol as a transport. This is how I see that basic interaction.

	struct bt_att;

	struct bt_att *bt_att_new(int fd);

	struct bt_att *att_ref(struct bt_att *att);
	void bt_att_unref(struct bt_att *att);

	bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
                                void *user_data, bt_att_destroy_func_t destroy);

	bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close);

For a lot of new code, I prefer if we are using file descriptors as base. Then it becomes easy to use on a socketpair for unit testing or put this onto a different transport.

The GIOChannel and BtIO forces us to have knowledge about every single detail of transport. I think we did this the wrong way around. The actual IO handling should be done inside struct att and be an implementation detail. And it should just deal with the transport and not the setup of the transport. The setup is out of scope for the protocol handling.

And I have been looking into similar things for src/shared/sdp.c along the same lines.

	struct bt_sdp_server;

	struct bt_sdp_server *bt_sdp_server_new(int fd, uint16_t mtu,
                                                struct bt_sdp_db *db);

	struct bt_sdp_server *bt_sdp_server_ref(struct bt_sdp_server *server);
	void bt_sdp_server_unref(struct bt_sdp_server *server);

	bool bt_sdp_server_set_debug(struct bt_sdp_server *server,
                                bt_sdp_debug_func_t callback,
                                void *user_data, bt_sdp_destroy_func_t destroy);

	bool bt_sdp_server_set_search_attribute_support(struct bt_sdp_server *server,
                                                                bool support);

	bool bt_sdp_server_set_close_on_unref(struct bt_sdp_server *server,
                                                        bool do_close);

I think you get the idea.

Regards

Marcel

