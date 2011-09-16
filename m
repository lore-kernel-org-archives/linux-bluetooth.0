Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E1R47Z5-0000QH-00.alexvm12e-mail-ru@f167.mail.ru>
References: <E1R47Z5-0000QH-00.alexvm12e-mail-ru@f167.mail.ru>
Date: Fri, 16 Sep 2011 11:07:01 +0300
Message-ID: <CABBYNZJzJPf1KYVpDJvr_UO722DTYzRV0vG6X7OnUHZVK8aq_A@mail.gmail.com>
Subject: Re: obexd: obex_handle_input: poll event HUP ERR
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alex Mach <alexvm12e@mail.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, Sep 15, 2011 at 11:44 AM, Alex Mach <alexvm12e@mail.ru> wrote:
>
> Hello,
>
> I have a problem with receiving files with obexd. After it receives header
>  it hangs up the connection with
> obex_handle_input: poll event HUP ERR
>
> bluez-4.95
> kernel-2.6.38.7 armv5tejl GNU/Linux
> libopenobex1-1.5
> obexd-0.42
>
> /usr/sbin/obexd --auto-accept --root=/var/obex
>
> obexd[844]: obexd daemon 0.42
> obexd[844]: src/main.c:main() Entering main loop
> obexd[844]: src/manager.c:manager_init()
> obexd[844]: src/plugin.c:plugin_init() Loading builtin plugins
> obexd[844]: src/transport.c:obex_transport_driver_register() driver 0x37a00 transport bluetooth registered
> obexd[844]: src/plugin.c:add_plugin() Plugin bluetooth loaded
> obexd[844]: src/mimetype.c:obex_mime_type_driver_register() driver 0x37a94 mimetype x-obex/folder-listing registered
> obexd[844]: src/mimetype.c:obex_mime_type_driver_register() driver 0x37a58 mimetype x-obex/capability registered
> obexd[844]: src/mimetype.c:obex_mime_type_driver_register() driver 0x37ad0 mimetype x-obex/folder-listing registered
> obexd[844]: src/mimetype.c:obex_mime_type_driver_register() driver 0x37a1c mimetype (null) registered
> obexd[844]: src/plugin.c:add_plugin() Plugin filesystem loaded
> obexd[844]: src/service.c:obex_service_driver_register() driver 0x37b18 service Object Push server registered
> obexd[844]: src/plugin.c:add_plugin() Plugin opp loaded
> obexd[844]: src/service.c:obex_service_driver_register() driver 0x37b64 service File Transfer server registered
> obexd[844]: src/plugin.c:add_plugin() Plugin ftp loaded
> obexd[844]: src/mimetype.c:obex_mime_type_driver_register() driver 0x37bf0 mimetype x-bt/phonebook registered
> obexd[844]: src/mimetype.c:obex_mime_type_driver_register() driver 0x37c2c mimetype x-bt/vcard-listing registered
> obexd[844]: src/mimetype.c:obex_mime_type_driver_register() driver 0x37c68 mimetype x-bt/vcard registered
> obexd[844]: src/service.c:obex_service_driver_register() driver 0x37bb0 service Phonebook Access server registered
> obexd[844]: src/plugin.c:add_plugin() Plugin pbap loaded
> obexd[844]: src/mimetype.c:obex_mime_type_driver_register() driver 0x37cf0 mimetype (null) registered
> obexd[844]: src/service.c:obex_service_driver_register() driver 0x37cb0 service Message Access server registered
> obexd[844]: src/plugin.c:add_plugin() Plugin mas loaded
> obexd[844]: plugins/irmc.c:irmc_init()
> obexd[844]: src/mimetype.c:obex_mime_type_driver_register() driver 0x37d3c mimetype (null) registered
> obexd[844]: src/service.c:obex_service_driver_register() driver 0x37d78 service IRMC Sync server registered
> obexd[844]: src/plugin.c:add_plugin() Plugin irmc loaded
> obexd[844]: src/mimetype.c:obex_mime_type_driver_register() driver 0x37dc4 mimetype (null) registered
> obexd[844]: src/service.c:obex_service_driver_register() driver 0x37e00 service OBEX server for SyncML, using SyncEvolution registered
> obexd[844]: src/plugin.c:add_plugin() Plugin syncevolution loaded
> obexd[844]: src/plugin.c:plugin_init() Loading plugins /var/buildroot-2011.05/output/staging/usr/lib/obex/plugins
> obexd[844]: plugins/bluetooth.c:start() listening on channel 9
> obexd[844]: plugins/bluetooth.c:start() listening on channel 10
> obexd[844]: src/server.c:obex_server_init() No service driver registered
> obexd[844]: plugins/bluetooth.c:start() listening on channel 15
> obexd[844]: plugins/bluetooth.c:start() listening on channel 14
> obexd[844]: plugins/bluetooth.c:start() listening on channel 19
> obexd[844]: plugins/bluetooth.c:start() listening on channel 16
> obexd[844]: plugins/bluetooth.c:find_adapter() FindAdapter(any)
> obexd[844]: plugins/bluetooth.c:add_record_reply() Registered: Object Push server, handle: 0x10005
> obexd[844]: plugins/bluetooth.c:add_record_reply() Registered: File Transfer server, handle: 0x10006
> obexd[844]: plugins/bluetooth.c:add_record_reply() Registered: Phonebook Access server, handle: 0x10007
> obexd[844]: plugins/bluetooth.c:add_record_reply() Registered: IRMC Sync server, handle: 0x10008
> obexd[844]: plugins/bluetooth.c:add_record_reply() Registered: OBEX server for SyncML, using SyncEvolution, handle: 0x10009
> obexd[844]: plugins/bluetooth.c:add_record_reply() Registered: Message Access server, handle: 0x1000a
>
> obexd[844]: bluetooth: New connection from: 04:A8:2A:36:D5:0C, channel 9
> obexd[844]: REQHINT(0x1), CONNECT(0x0), (null)(0x0)
> obexd[844]: REQ(0x2), CONNECT(0x0), (null)(0x0)
> obexd[844]: src/obex.c:cmd_connect() Version: 0x10. Flags: 0x00  OBEX packet length: 32767
> obexd[844]: src/obex.c:cmd_connect() Resizing stream chunks to 32567
> obexd[844]: src/obex.c:cmd_connect() Selected driver: Object Push server
> obexd[844]: REQ(0x2), CONNECT(0x0), CONTINUE(0x10)
> obexd[844]: REQDONE(0x3), CONNECT(0x0), (null)(0x0)
> obexd[844]: REQHINT(0x1), PUT(0x2), (null)(0x0)
> obexd[844]: REQCHECK(0xb), PUT(0x2), (null)(0x0)
> obexd[844]: src/obex.c:check_put() OBEX_HDR_NAME: (null)

Problem seems to be here, apparently we could not convert the name
received (Unicode length 18 according to hcidump), so the name is not
set cause plugin/ftp.c:268 to fail. Could you please check what is the
string in the header and if that is really a utf16 as the spec
mandates.


-- 
Luiz Augusto von Dentz
