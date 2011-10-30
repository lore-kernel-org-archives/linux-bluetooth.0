Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Date: Sun, 30 Oct 2011 07:56:55 +0100
Subject: RE: GATT Dbus API on BlueZ - attirbute-api.txt modifications
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DCBC472E@dnce01.ent.ti.com>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
	<4EA6143E.4000606@googlemail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8D28@dnce01.ent.ti.com>
	<CAKT1EBeJB2FDrv6Xp_bGV3eFDEe5ecvnBN0rKniYxw5++Q9NfA@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8F85@dnce01.ent.ti.com>
	<CAKT1EBcd6dQq3bzOsW3Fuwv=d8J=yDvsJjbp_ELEAQUjfyRx9g@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA9265@dnce01.ent.ti.com>
	<alpine.DEB.2.02.1110270003090.30044@mathewm-linux>
	<7769C83744F2C34A841232EF77AEA20C01DCBC3F03@dnce01.ent.ti.com>
	<CABBYNZ+Hq4-AAg3TsLi-Vh0eC2p_ZtD2vthBfc3Unww+Km6-Mg@mail.gmail.com>
	<CAJdJm_Po7iAOoB673XW6D3gTsCn_ME8CHEo0VcWzi5FKX9xghA@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCBC41E0@dnce01.ent.ti.com>
	<CAJdJm_NKmrx-qieUFMibPSL3L17=-nwKEjQrfvmf77HFsU8yaw@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCBC4234@dnce01.ent.ti.com>
	<CAJdJm_M5LS6o4yiiG-7-KedUF6_dafYbLX=Vqj0QJ4rV926gpg@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCBC4275@dnce01.ent.ti.com>
 <CAJdJm_Pjn=7DWPES9fdZJntSfi_h14WxWfORuoRa+tWwnk9Dfw@mail.gmail.com>
In-Reply-To: <CAJdJm_Pjn=7DWPES9fdZJntSfi_h14WxWfORuoRa+tWwnk9Dfw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson,
 
> The PropertyChanged signal will be emitted once the value is written.
> Applications should listen to this signal if they want to know when/if
> the value has been updated on peer device. So if the application has
> some requirement to have the value written in, let's say, 20 seconds,
> it starts a timer when doing a SetProperty(). If the timer expires and
> PropertyChanged was not received, the value can be considered as "not
> written yet". It is up to the application what to do later.
> 
I could not find this in the upstream code. Can you please point me to where this happens?
What happens if this value is written from another client ? What happens if this value is
changed by the server at some unknown time, and the client is responsible for updating this value occasionally by polling the server ? I could not find in the upstream code any other gatt_read_char , except for when connection is established.

> 
> The value *can* only be updated once the connection is established. a
> SetProperty() may trigger this connection. But it will *not* block
> waiting for the connection establishment (which may be between "now"
> and "never"). You monitor the PropertyChanged signal to know when/if
> the value was written.
> 
Again, you force a specific scenario, where you believe that the server should notify/indicate the client of any changes. What if not ? What if the profile requires you to poll ? For example, the health thermometer notification/indication is only optional. What will a client do if it needs to poll for a new value? Should it disconnect and reconnect ?

> 
> The value update is started by the time SetProperty() is called. But
> it is not guaranteed to finish by the time it returns. You should
> listen to the PropertyChanged signal for that.
> 
I don't get why you bind setProperty with value change here.


> 
> The "update process" is started by GetProperties(), but it will not
> block. you have PropertiesChanged for knowing then the "fresh" value
> has been read.
> 
I could not find this either in the code. Currently, upstream, this is what append_char_dict does :
static void append_char_dict(DBusMessageIter *iter, struct characteristic *chr)
 179 {
 180         DBusMessageIter dict;
 181         const char *name = "";
 182         char *uuid;
 183 
 184         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 185                         DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
 186                         DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 187                         DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 188 
 189         uuid = g_strdup(chr->type);
 190         dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
 191         g_free(uuid);
 192 
 193         /* FIXME: Translate UUID to name. */
 194         dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &name);
 195 
 196         if (chr->desc)
 197                 dict_append_entry(&dict, "Description", DBUS_TYPE_STRING,
 198                                                                 &chr->desc);
 199 
 200         if (chr->value)
 201                 dict_append_array(&dict, "Value", DBUS_TYPE_BYTE, &chr->value,
 202                                                                 chr->vlen);
 203 
 204         /* FIXME: Missing Format, Value and Representation */
 205 
 206         dbus_message_iter_close_container(iter, &dict);
 207 }
Nothing here does any of the things you suggest. If I'm wrong, let me know where it does that.


> 
> You need to ask this for the guys who implemented the concept :) But
> AFAIK it is so to avoid too many D-Bus round trips.
> 
So to avoid too many round trips I need to get all the information at once ? Characteristic Properties are values that do not change frequently. Char properties, write permissions for example are set and fixed. Value however is changing all the time. I do not see a reason to put all those together - I do not need to get the write modes each time I get a value.

> > 3. Writing to the value property needs to be done in one of 4
> methods. How do you support that in the existing bluez property format
> ?
> 
> Based on what the characteristic supports, and the state of the link.
> See below.
> 
So again, we take the easy way to decide what's best for the user, instead of giving him control.

 
> I can't find such "authenticated write".
> 
Authenticated write is write on an encrypted link. In GATT /GAP LE specs, it is not required to establish a link and immediately raise the security level. It is assumed that the client can read the ATT error code, and figure out that the write needs encryption, so the client may initiate security mode change. Currently, we force the link security mode upgrade on connection according to bond state.

> 
> "This sub-procedure is used to write a Characteristic Value to a server
> when the
> client knows the Characteristic Value Handle and the ATT Bearer is not
> encrypted. This sub-procedure shall only be used if the Characteristic
> Proper-
> ties authenticated bit is enabled and the client and server device
> share a bond
> as defined in [Vol. 3] Part C, Generic Access Profile."
> 
> Do you see that all necessary information to know when to use it or
> not is already known by BlueZ?
> 
Yes. I see that. However, I'm not sure we need to take control over decisions like this.

> Reliable Writes: This is a different beast. According to the spec, it
> can be used in two situations:
> 
> * "assurance is required that the correct Characteristic Value is
> going to be written..."
> * "multiple values must be written, in order, in a single operation"
> 
> Both usecases cannot be satisfied on current API, and not even on your
> proposal.
> 
> To me, it seems support for Reliable Writes require a separate set of
> functions, if we want to support both usecases listed on the spec.
> 
So we need to be prepared, and make sure the API stays and does not change too much when we do add support for this type of write.

> Note that there is a condition, for "optional" on server. The server
> cannot add/remove services during its lifetime, or at least cannot
> change the attribute handles. We don't have this guarantee as well, as
> handles are allocated dynamically during each plugin initialization.
> 
Yes. How do we currently handle a request for updating services and characteristics? Do we remove all old object paths and create new ones ?


Best regards,
Chen Ganir.

