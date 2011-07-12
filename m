Return-Path: <cyrus@holtmann.org>
Message-Id: <7.0.1.0.2.20110712232418.033d6f30@gmx.net>
Date: Tue, 12 Jul 2011 23:38:53 +0200
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: Peter Kornatowski <pkorn@gmx.net>
Subject: Re: Media API with more than one headset
Cc: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <7.0.1.0.2.20110711234654.033dd5a8@gmx.net>
References: <7.0.1.0.2.20110622230344.031f5790@gmx.net>
 <BANLkTikuRgeFW-fXckR4ST14idxPSmNP7g@mail.gmail.com>
 <7.0.1.0.2.20110627205517.03250550@gmx.net>
 <BANLkTinFieuN8HSLu8-pTaMix9r48d6HBw@mail.gmail.com>
 <BANLkTimMQcjj3A=cNaUWY4xByY2WrhA9RA@mail.gmail.com>
 <BANLkTiknkbZcS2AASzS_qeXbNJ3_Qa2e1A@mail.gmail.com>
 <7.0.1.0.2.20110629214327.0321b4e0@gmx.net>
 <7.0.1.0.2.20110706214918.03262000@gmx.net>
 <CABBYNZ+y1EkxNOr53Cr2SkbYfgKV3SCDK10ejo1mjHzdcB2BvQ@mail.gmail.com>
 <7.0.1.0.2.20110707101900.03230f68@gmx.net>
 <CABBYNZ+7952MAawEKusu2UcPwbGQ1ZS8sKiDmDLg+ZiE0-5wPw@mail.gmail.com>
 <7.0.1.0.2.20110707213702.033c8098@gmx.net>
 <CABBYNZ+w2kFrKiuCpXFeXo+uTX1cf+DxQGWVD2F_GEESOoW+Aw@mail.gmail.com>
 <7.0.1.0.2.20110708213144.033af340@gmx.net>
 <7.0.1.0.2.20110711234654.033dd5a8@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_4320078==_"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=====================_4320078==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 00:07 12.07.2011, Peter Kornatowski wrote:
>At 21:43 08.07.2011, Peter Kornatowski wrote:
>>Hi Luiz,
>>
>>At 12:08 08.07.2011, Luiz Augusto von Dentz wrote:
>>>Hi Peter,
>>>
>>>On Thu, Jul 7, 2011 at 10:57 PM, Peter Kornatowski <pkorn@gmx.net> wrote:
>>> > I'm calling Acquire when SetConfiguration is called by bluez 
>>> (isn't that the
>>> > correct spot, cause there you get the transport path?). I 
>>> attached the whole
>>> > modified script, so you can see exactly what I'm doing.
>>>
>>>As I explained in the last email you have to reply to the
>>>SetConfiguration before you are able to do Acquire, that is on purpose
>>>to avoid a possible deadlock where you are the application is waiting
>>>for Acquire to complete but bluetoothd is waiting the application to
>>>reply to SetConfiguration, bluetoothd won't block but the application
>>>may block trying to Acquire and by doing that it is not able to reply
>>>to SetConfiguration.
>>
>>This is why I'm calling Acquire asynchronously. But ok, I will test 
>>it with a postponed Acquire.
>
>Tested it with a seperate python-script for calling Acquire 
>(attached it). Modified the previous script so that it doesn't call 
>Acquire anymore.
>So when registering two endpoints and connecting one headset, I see 
>bluez calling SetConfiguration for both endpoints (so two transport 
>paths with just different fdX at the end). I then call Acquire with 
>the new script for one endpoint at get the headset into playing mode 
>every time. When trying to call Acquire for the second headset I 
>always get Operation Not Authorized (which is fine I guess, but the 
>second SetConfiguration call in the first place is not). When 
>stopping this last scquire-script with ctrl+c (just the one that 
>produced Operation Not Authorized), bluetoothd always segfaults. 
>Stopping the other acquire-script or the endpoint-dual doesn't 
>segfault bluetoothd. I could reproduce this with my C code as well.
>
>Also with endpoint and Acquire being in two different scripts I 
>could play around a little and found out that starting more 
>endpoints than there are connected headsets is not a good idea, even 
>when you don't call Acquire. So to workaround this behaviour I have 
>to wait for a headset to connect, then register just one endpoint 
>for it and call Acquire. For the next headset that connects I have 
>to do the same. And when a headset disconnects, the endpoint has to 
>be unregistered and closed as well. Or is this the intended way of 
>doing it anyway?

OK, so I implemented it this way and I don't get Operation Not 
Authorized or bluetoothd segfaults anymore. But I still have the 
"sco_bind: Address in use" problem I wrote about some e-mails ago. 
The first time I call Acquire for each headset it works fine, but 
after disconnecting and reconnecting a headset it always ends with 
the error message. And I even unregister and re-register the endpoint 
object. And the error message sounds like there is a problem with the 
socket, but I thought binding and releasing the socket is handled 
internally by bluez and not by the media api. On the other hand, I 
couldn't reproduce the problem with any of the python scripts...
I attached the syslog and hopefully someone will see something 
unusual. Because I tried out stuff for many hours and just can't get 
it to work. This is the way I implemented it roughly (just the main 
dbus functions):

After headset connect:
g_dbus_connection_register_object(service_connection, 
"/test/endpoint1", introspection_data->interfaces[0], 
&interface_vtable, NULL, NULL, &error);
g_dbus_proxy_new_sync(bluez_connection, G_DBUS_PROXY_FLAGS_NONE, 
NULL, "org.bluez", adapter_path, "org.bluez.Media", NULL, &error);
g_dbus_proxy_call(bluez_media_proxy, "RegisterEndpoint", props, 
G_DBUS_CALL_FLAGS_NONE, -1, NULL, (GAsyncReadyCallback)reg_ep_cb, NULL);

Then SetConfiguration is called by bluez, and there I call:
g_dbus_method_invocation_return_value(invocation, NULL);
g_dbus_proxy_new_for_bus_sync(G_BUS_TYPE_SYSTEM, 
G_DBUS_PROXY_FLAGS_NONE, NULL, "org.bluez", transport_path, 
"org.bluez.MediaTransport", NULL, &error);
g_dbus_message_new_method_call("org.bluez", transport_path, 
"org.bluez.MediaTransport", "Acquire");
g_dbus_message_set_body(method_call_message, g_variant_new("(s)", "rw"));
g_dbus_connection_send_message_with_reply(media_transport_connection, 
method_call_message, G_DBUS_SEND_MESSAGE_FLAGS_NONE, -1, NULL, NULL, 
acquire_cb, NULL);
Then in the acquire_cb I get the file descriptor (at least for the 
first time this headset connects).

When a headset disconnects, I call:
g_dbus_proxy_call(media_transport, "Release", g_variant_new("(s)", 
"rw"), G_DBUS_CALL_FLAGS_NONE, -1, NULL, 
(GAsyncReadyCallback)release_cb, NULL);
g_dbus_proxy_call(bluez_media, "UnregisterEndpoint", 
g_variant_new("(o)", "/test/endpoint1"), G_DBUS_CALL_FLAGS_NONE, -1, 
NULL, (GAsyncReadyCallback)unreg_ep_cb, NULL);
g_dbus_connection_unregister_object(service_connection, registration_id);

Any hints are appreciated.

Thanks,
Peter



>>> > It also works for the first headset or if all headsets are in 
>>> connected mode
>>> > and you start the script, so generally it should be ok.
>>> > But it doesn't work if you start the script and then connect the first
>>> > headset (or start the script after just one headset is in 
>>> connected mode).
>>> > Then the headset gets into playing mode, but bluez tries to put it into
>>> > playing mode on the other endpoint, too (at least it looks that way to me
>>> > cause SetConfiguration is being called twice). So then Acquire is being
>>> > called twice, too. For one call I get the file descriptor, but 
>>> for the other
>>> > call I get "Operation Not Authorized". Maybe because the second
>>> > SetConfiguration is called for the other endpoint, which is on the other
>>> > adapter with which the headset is not paired (each headset is only paired
>>> > with one adapter). On the other hand, the transport path from both
>>> > SetConfiguration calls is for the same adapter... But when you 
>>> then connect
>>> > the second headset (which is paired with the other adapter), 
>>> bluez doesn't
>>> > call SetConfiguration for it (probably because this endpoint is still
>>> > "blocked" by the first headset, but it shouldn't be).
>>>
>>>The Operation Not Authorized in because you didn't reply to
>>>SetConfiguration, also bluetoothd will try to match the profile
>>>capabilities with the endpoint capabilities and then call
>>>SetConfiguration to the endpoint to confirm if it is able to handle
>>>the transport, in theory I don't see any problem to the same endpoint
>>>to get multiple SetConfiguration as long it is for different devices,
>>>but perhaps we need to limit to only one transport per endpoint which
>>>is usually the case for a2dp since the sep has the in_use flag.
>>
>>Where do you see that I'm not replying to SetConfiguration? Because 
>>of the asynchronous Acquire call it should always reply.
>>But the limit would probably be a good idea.
>>
>>
>>> > Additionally, when you try to end the script with ctrl+c now, bluetoothd
>>> > segfaults with: segfault at 3c ip b75359d5 sp bfd25c10 error 4 in
>>> > libdbus-1.so.3.5.7[b7521000+48000]
>>> > I tried the whole use case as user and as root, but no difference. I also
>>> > attached the syslog output (bluetoothd started with -d).
>>>
>>>The syslog doesn't seems to indicate any crashes, did you left it out?
>>>Btw, to get more information about the crash please run bluetooth with
>>>valgrind e.g:
>>>
>>>sudo G_SLICE=always-malloc G_DEBUG=gc-friendly,resident-module
>>>valgrind --trace-children=yes  ./bluetoothd -dn
>>
>>I didn't leave out anything. I attached the valgrind log. This is what I did:
>>1. Started bluetoothd with valgrind.
>>2. Started simple-endpoint-dual (see my last e-mail) with no 
>>headsets in connected mode.
>>3. Connected one headset (got one file descriptor and one Operation 
>>Not Authorized).
>>4. Ended simple-endpoint-dual with ctrl+c (and bluetoothd segfaults).
>>
>>
>>>--
>>>Luiz Augusto von Dentz
>>>--
>>
>>Peter
>>
>>
>
>

--=====================_4320078==_
Content-Type: application/octet-stream; name="headset_disc_conn.syslog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="headset_disc_conn.syslog"

SnVsIDEyIDIxOjI1OjEzIHBldGVyIGJsdWV0b290aGRbNzg5OF06IEF1ZGlvIGNvbm5lY3Rpb24g
Z290IGRpc2Nvbm5lY3RlZApKdWwgMTIgMjE6MjU6MTMgcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTog
YXVkaW8vaGVhZHNldC5jOmhlYWRzZXRfc2V0X3N0YXRlKCkgU3RhdGUgY2hhbmdlZCAvb3JnL2Js
dWV6Lzc4OTgvaGNpMC9kZXZfMDBfMjNfN0ZfMkJfNTRfQUM6IEhFQURTRVRfU1RBVEVfUExBWUlO
RyAtPiBIRUFEU0VUX1NUQVRFX0NPTk5FQ1RFRApKdWwgMTIgMjE6MjU6MTMgcGV0ZXIgYmx1ZXRv
b3RoZFs3ODk4XTogYXVkaW8vbWVkaWEuYzpoZWFkc2V0X3N0YXRlX2NoYW5nZWQoKSAKSnVsIDEy
IDIxOjI1OjEzIHBldGVyIGJsdWV0b290aGRbNzg5OF06IHBsdWdpbnMvaGNpb3BzLmM6ZGlzY29u
bl9jb21wbGV0ZSgpIGhhbmRsZSA0MyBzdGF0dXMgMHgwMApKdWwgMTIgMjE6MjU6MTUgcGV0ZXIg
Ymx1ZXRvb3RoZFs3ODk4XTogYXVkaW8vaGVhZHNldC5jOnJmY29tbV9pb19jYigpIEVSUiBvciBI
VVAgb24gUkZDT01NIHNvY2tldApKdWwgMTIgMjE6MjU6MTUgcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4
XTogYXVkaW8vdGVsZXBob255LmM6dGVsZXBob255X2RldmljZV9kaXNjb25uZWN0ZWQoKSB0ZWxl
cGhvbnktZHVtbXk6IGRldmljZSAweGI5N2E1NzIwIGRpc2Nvbm5lY3RlZApKdWwgMTIgMjE6MjU6
MTUgcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogYXVkaW8vaGVhZHNldC5jOmhlYWRzZXRfc2V0X3N0
YXRlKCkgU3RhdGUgY2hhbmdlZCAvb3JnL2JsdWV6Lzc4OTgvaGNpMC9kZXZfMDBfMjNfN0ZfMkJf
NTRfQUM6IEhFQURTRVRfU1RBVEVfQ09OTkVDVEVEIC0+IEhFQURTRVRfU1RBVEVfRElTQ09OTkVD
VEVECkp1bCAxMiAyMToyNToxNSBwZXRlciBibHVldG9vdGhkWzc4OThdOiBhdWRpby9tZWRpYS5j
OmhlYWRzZXRfc3RhdGVfY2hhbmdlZCgpIApKdWwgMTIgMjE6MjU6MTUgcGV0ZXIgYmx1ZXRvb3Ro
ZFs3ODk4XTogYXVkaW8vbWVkaWEuYzpoZWFkc2V0X3N0YXRlX2NoYW5nZWQoKSBDbGVhciBlbmRw
b2ludCAweGI5NzlkMDIwCkp1bCAxMiAyMToyNToxNSBwZXRlciBibHVldG9vdGhkWzc4OThdOiBh
dWRpby90cmFuc3BvcnQuYzptZWRpYV90cmFuc3BvcnRfcmVtb3ZlKCkgVHJhbnNwb3J0IC9vcmcv
Ymx1ZXovNzg5OC9oY2kwL2Rldl8wMF8yM183Rl8yQl81NF9BQy9mZDcgT3duZXIgOjEuNTI4Ckp1
bCAxMiAyMToyNToxNSBwZXRlciBibHVldG9vdGhkWzc4OThdOiBhdWRpby90cmFuc3BvcnQuYzpt
ZWRpYV90cmFuc3BvcnRfcmVsZWFzZSgpIFRyYW5zcG9ydCAvb3JnL2JsdWV6Lzc4OTgvaGNpMC9k
ZXZfMDBfMjNfN0ZfMkJfNTRfQUMvZmQ3OiByZWFkIGxvY2sgcmVsZWFzZWQKSnVsIDEyIDIxOjI1
OjE1IHBldGVyIGJsdWV0b290aGRbNzg5OF06IGF1ZGlvL3RyYW5zcG9ydC5jOm1lZGlhX3RyYW5z
cG9ydF9yZWxlYXNlKCkgVHJhbnNwb3J0IC9vcmcvYmx1ZXovNzg5OC9oY2kwL2Rldl8wMF8yM183
Rl8yQl81NF9BQy9mZDc6IHdyaXRlIGxvY2sgcmVsZWFzZWQKSnVsIDEyIDIxOjI1OjE1IHBldGVy
IGJsdWV0b290aGRbNzg5OF06IGF1ZGlvL3RyYW5zcG9ydC5jOm1lZGlhX293bmVyX2ZyZWUoKSBP
d25lciA6MS41MjgKSnVsIDEyIDIxOjI1OjE1IHBldGVyIGJsdWV0b290aGRbNzg5OF06IEVuZHBv
aW50IHVucmVnaXN0ZXJlZDogc2VuZGVyPToxLjUyOCBwYXRoPS90ZXN0L2VuZHBvaW50MApKdWwg
MTIgMjE6MjU6MTYgcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogcGx1Z2lucy9oY2lvcHMuYzpkaXNj
b25uX2NvbXBsZXRlKCkgaGFuZGxlIDM4IHN0YXR1cyAweDAwCkp1bCAxMiAyMToyNToxNiBwZXRl
ciBibHVldG9vdGhkWzc4OThdOiBzcmMvZXZlbnQuYzpidGRfZXZlbnRfZGlzY29ubl9jb21wbGV0
ZSgpIApKdWwgMTIgMjE6MjU6MTYgcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogc3JjL2FkYXB0ZXIu
YzphZGFwdGVyX3JlbW92ZV9jb25uZWN0aW9uKCkgCgoKCkp1bCAxMiAyMToyNToyOCBwZXRlciBi
bHVldG9vdGhkWzc4OThdOiBwbHVnaW5zL2hjaW9wcy5jOmNvbm5fY29tcGxldGUoKSBzdGF0dXMg
MHgwMApKdWwgMTIgMjE6MjU6MjggcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogc3JjL2FkYXB0ZXIu
YzphZGFwdGVyX2dldF9kZXZpY2UoKSAwMDoyMzo3RjoyQjo1NDpBQwpKdWwgMTIgMjE6MjU6Mjgg
cGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogRW5kcG9pbnQgcmVnaXN0ZXJlZDogc2VuZGVyPToxLjUy
OCBwYXRoPS90ZXN0L2VuZHBvaW50MApKdWwgMTIgMjE6MjU6MjggcGV0ZXIgYmx1ZXRvb3RoZFs3
ODk4XTogcGx1Z2lucy9oY2lvcHMuYzpyZW1vdGVfZmVhdHVyZXNfaW5mb3JtYXRpb24oKSBoY2kw
IHN0YXR1cyAwCkp1bCAxMiAyMToyNToyOCBwZXRlciBibHVldG9vdGhkWzc4OThdOiBwbHVnaW5z
L2hjaW9wcy5jOmxpbmtfa2V5X3JlcXVlc3QoKSBoY2kwIGRiYSAwMDoyMzo3RjoyQjo1NDpBQwpK
dWwgMTIgMjE6MjU6MjggcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogcGx1Z2lucy9oY2lvcHMuYzpn
ZXRfYXV0aF9pbmZvKCkgaGNpMCBkYmEgMDA6MjM6N0Y6MkI6NTQ6QUMKSnVsIDEyIDIxOjI1OjI4
IHBldGVyIGJsdWV0b290aGRbNzg5OF06IHBsdWdpbnMvaGNpb3BzLmM6bGlua19rZXlfcmVxdWVz
dCgpIGtlcm5lbCBhdXRoIHJlcXVpcmVtZW50cyA9IDB4MDQKSnVsIDEyIDIxOjI1OjI4IHBldGVy
IGJsdWV0b290aGRbNzg5OF06IHBsdWdpbnMvaGNpb3BzLmM6bGlua19rZXlfcmVxdWVzdCgpIE1h
dGNoaW5nIGtleSBmb3VuZApKdWwgMTIgMjE6MjU6MjggcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTog
cGx1Z2lucy9oY2lvcHMuYzpsaW5rX2tleV9yZXF1ZXN0KCkgbGluayBrZXkgdHlwZSAweDA0Ckp1
bCAxMiAyMToyNToyOCBwZXRlciBibHVldG9vdGhkWzc4OThdOiBwbHVnaW5zL2hjaW9wcy5jOmxp
bmtfa2V5X3JlcXVlc3QoKSBoY2kwIGRiYSAwMDoyMzo3RjoyQjo1NDpBQwpKdWwgMTIgMjE6MjU6
MjggcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogcGx1Z2lucy9oY2lvcHMuYzpnZXRfYXV0aF9pbmZv
KCkgaGNpMCBkYmEgMDA6MjM6N0Y6MkI6NTQ6QUMKSnVsIDEyIDIxOjI1OjI4IHBldGVyIGJsdWV0
b290aGRbNzg5OF06IHBsdWdpbnMvaGNpb3BzLmM6bGlua19rZXlfcmVxdWVzdCgpIGtlcm5lbCBh
dXRoIHJlcXVpcmVtZW50cyA9IDB4MDQKSnVsIDEyIDIxOjI1OjI4IHBldGVyIGJsdWV0b290aGRb
Nzg5OF06IHBsdWdpbnMvaGNpb3BzLmM6bGlua19rZXlfcmVxdWVzdCgpIE1hdGNoaW5nIGtleSBm
b3VuZApKdWwgMTIgMjE6MjU6MjggcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogcGx1Z2lucy9oY2lv
cHMuYzpsaW5rX2tleV9yZXF1ZXN0KCkgbGluayBrZXkgdHlwZSAweDA0Ckp1bCAxMiAyMToyNToy
OCBwZXRlciBibHVldG9vdGhkWzc4OThdOiBwbHVnaW5zL2hjaW9wcy5jOmF1dGhfY29tcGxldGUo
KSBoY2kwIHN0YXR1cyAwCkp1bCAxMiAyMToyNToyOCBwZXRlciBibHVldG9vdGhkWzc4OThdOiBw
bHVnaW5zL2hjaW9wcy5jOmJvbmRpbmdfY29tcGxldGUoKSBzdGF0dXMgMHgwMApKdWwgMTIgMjE6
MjU6MjggcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogc3JjL2V2ZW50LmM6YnRkX2V2ZW50X2JvbmRp
bmdfY29tcGxldGUoKSBzdGF0dXMgMHgwMApKdWwgMTIgMjE6MjU6MjggcGV0ZXIgYmx1ZXRvb3Ro
ZFs3ODk4XTogc3JjL2FkYXB0ZXIuYzphZGFwdGVyX2dldF9kZXZpY2UoKSAwMDoyMzo3RjoyQjo1
NDpBQwpKdWwgMTIgMjE6MjU6MjggcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogc3JjL2RldmljZS5j
OmRldmljZV9ib25kaW5nX2NvbXBsZXRlKCkgYm9uZGluZyAobmlsKSBzdGF0dXMgMHgwMApKdWwg
MTIgMjE6MjU6MjggcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogYXVkaW8vaGVhZHNldC5jOmhlYWRz
ZXRfc2V0X3N0YXRlKCkgU3RhdGUgY2hhbmdlZCAvb3JnL2JsdWV6Lzc4OTgvaGNpMC9kZXZfMDBf
MjNfN0ZfMkJfNTRfQUM6IEhFQURTRVRfU1RBVEVfRElTQ09OTkVDVEVEIC0+IEhFQURTRVRfU1RB
VEVfQ09OTkVDVElORwpKdWwgMTIgMjE6MjU6MjggcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogYXVk
aW8vbWVkaWEuYzpoZWFkc2V0X3N0YXRlX2NoYW5nZWQoKSAKSnVsIDEyIDIxOjI1OjI4IHBldGVy
IGJsdWV0b290aGRbNzg5OF06IGF1ZGlvL21lZGlhLmM6bWVkaWFfZW5kcG9pbnRfYXN5bmNfY2Fs
bCgpIENhbGxpbmcgU2V0Q29uZmlndXJhdGlvbjogbmFtZSA9IDoxLjUyOCBwYXRoID0gL3Rlc3Qv
ZW5kcG9pbnQwCkp1bCAxMiAyMToyNToyOCBwZXRlciBibHVldG9vdGhkWzc4OThdOiBhdWRpby9o
ZWFkc2V0LmM6aGVhZHNldF9jb25uZWN0X2NiKCkgL29yZy9ibHVlei83ODk4L2hjaTAvZGV2XzAw
XzIzXzdGXzJCXzU0X0FDOiBDb25uZWN0ZWQgdG8gMDA6MjM6N0Y6MkI6NTQ6QUMKSnVsIDEyIDIx
OjI1OjI4IHBldGVyIGJsdWV0b290aGRbNzg5OF06IGF1ZGlvL3RyYW5zcG9ydC5jOm1lZGlhX3Ry
YW5zcG9ydF9hY3F1aXJlKCkgVHJhbnNwb3J0IC9vcmcvYmx1ZXovNzg5OC9oY2kwL2Rldl8wMF8y
M183Rl8yQl81NF9BQy9mZDg6IHJlYWQgbG9jayBhY3F1aXJlZApKdWwgMTIgMjE6MjU6MjggcGV0
ZXIgYmx1ZXRvb3RoZFs3ODk4XTogYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfdHJhbnNwb3J0X2Fj
cXVpcmUoKSBUcmFuc3BvcnQgL29yZy9ibHVlei83ODk4L2hjaTAvZGV2XzAwXzIzXzdGXzJCXzU0
X0FDL2ZkODogd3JpdGUgbG9jayBhY3F1aXJlZApKdWwgMTIgMjE6MjU6MjggcGV0ZXIgYmx1ZXRv
b3RoZFs3ODk4XTogYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfb3duZXJfY3JlYXRlKCkgT3duZXIg
Y3JlYXRlZDogc2VuZGVyPToxLjUyOCBhY2Nlc3N0eXBlPXJ3Ckp1bCAxMiAyMToyNToyOCBwZXRl
ciBibHVldG9vdGhkWzc4OThdOiBhdWRpby90cmFuc3BvcnQuYzptZWRpYV9yZXF1ZXN0X2NyZWF0
ZSgpIFJlcXVlc3QgY3JlYXRlZDogbWV0aG9kPUFjcXVpcmUgaWQ9OQpKdWwgMTIgMjE6MjU6Mjgg
cGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfb3duZXJfYWRk
KCkgT3duZXIgOjEuNTI4IFJlcXVlc3QgQWNxdWlyZQpKdWwgMTIgMjE6MjU6MjggcGV0ZXIgYmx1
ZXRvb3RoZFs3ODk4XTogYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfdHJhbnNwb3J0X2FkZCgpIFRy
YW5zcG9ydCAvb3JnL2JsdWV6Lzc4OTgvaGNpMC9kZXZfMDBfMjNfN0ZfMkJfNTRfQUMvZmQ4IE93
bmVyIDoxLjUyOApKdWwgMTIgMjE6MjU6MjkgcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogYXVkaW8v
aGVhZHNldC5jOmhhbmRsZV9ldmVudCgpIFJlY2VpdmVkIEFUK0JSU0Y9MjQKSnVsIDEyIDIxOjI1
OjI5IHBldGVyIGJsdWV0b290aGRbNzg5OF06IGF1ZGlvL2hlYWRzZXQuYzpwcmludF9oZl9mZWF0
dXJlcygpIEhGUCBIRiBmZWF0dXJlczogIlZvaWNlIHJlY29nbml0aW9uIGFjdGl2YXRpb24iICJS
ZW1vdGUgdm9sdW1lIGNvbnRyb2wiIApKdWwgMTIgMjE6MjU6MjkgcGV0ZXIgYmx1ZXRvb3RoZFs3
ODk4XTogYXVkaW8vaGVhZHNldC5jOmhhbmRsZV9ldmVudCgpIFJlY2VpdmVkIEFUK0NJTkQ9PwpK
dWwgMTIgMjE6MjU6MjkgcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogYXVkaW8vaGVhZHNldC5jOmhh
bmRsZV9ldmVudCgpIFJlY2VpdmVkIEFUK0NJTkQ/Ckp1bCAxMiAyMToyNToyOSBwZXRlciBibHVl
dG9vdGhkWzc4OThdOiBhdWRpby9oZWFkc2V0LmM6aGFuZGxlX2V2ZW50KCkgUmVjZWl2ZWQgQVQr
Q01FUj0zLCAwLCAwLCAxCkp1bCAxMiAyMToyNToyOSBwZXRlciBibHVldG9vdGhkWzc4OThdOiBh
dWRpby9oZWFkc2V0LmM6ZXZlbnRfcmVwb3J0aW5nKCkgRXZlbnQgcmVwb3J0aW5nIChDTUVSKTog
bW9kZT0zLCBpbmQ9MQpKdWwgMTIgMjE6MjU6MjkgcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogYXVk
aW8vaGVhZHNldC5jOmhmcF9zbGNfY29tcGxldGUoKSBIRlAgU2VydmljZSBMZXZlbCBDb25uZWN0
aW9uIGVzdGFibGlzaGVkCkp1bCAxMiAyMToyNToyOSBwZXRlciBibHVldG9vdGhkWzc4OThdOiBh
dWRpby90ZWxlcGhvbnkuYzp0ZWxlcGhvbnlfZGV2aWNlX2Nvbm5lY3RlZCgpIHRlbGVwaG9ueS1k
dW1teTogZGV2aWNlIDB4Yjk3YTU3MjAgY29ubmVjdGVkCkp1bCAxMiAyMToyNToyOSBwZXRlciBi
bHVldG9vdGhkWzc4OThdOiBhdWRpby9oZWFkc2V0LmM6aGVhZHNldF9zZXRfc3RhdGUoKSBTdGF0
ZSBjaGFuZ2VkIC9vcmcvYmx1ZXovNzg5OC9oY2kwL2Rldl8wMF8yM183Rl8yQl81NF9BQzogSEVB
RFNFVF9TVEFURV9DT05ORUNUSU5HIC0+IEhFQURTRVRfU1RBVEVfQ09OTkVDVEVECkp1bCAxMiAy
MToyNToyOSBwZXRlciBibHVldG9vdGhkWzc4OThdOiBhdWRpby9tZWRpYS5jOmhlYWRzZXRfc3Rh
dGVfY2hhbmdlZCgpIApKdWwgMTIgMjE6MjU6MjkgcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogc2Nv
X2JpbmQ6IEFkZHJlc3MgYWxyZWFkeSBpbiB1c2UgKDk4KQpKdWwgMTIgMjE6MjU6MjkgcGV0ZXIg
Ymx1ZXRvb3RoZFs3ODk4XTogYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfdHJhbnNwb3J0X3JlbW92
ZSgpIFRyYW5zcG9ydCAvb3JnL2JsdWV6Lzc4OTgvaGNpMC9kZXZfMDBfMjNfN0ZfMkJfNTRfQUMv
ZmQ4IE93bmVyIDoxLjUyOApKdWwgMTIgMjE6MjU6MjkgcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTog
YXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfdHJhbnNwb3J0X3JlbGVhc2UoKSBUcmFuc3BvcnQgL29y
Zy9ibHVlei83ODk4L2hjaTAvZGV2XzAwXzIzXzdGXzJCXzU0X0FDL2ZkODogcmVhZCBsb2NrIHJl
bGVhc2VkCkp1bCAxMiAyMToyNToyOSBwZXRlciBibHVldG9vdGhkWzc4OThdOiBhdWRpby90cmFu
c3BvcnQuYzptZWRpYV90cmFuc3BvcnRfcmVsZWFzZSgpIFRyYW5zcG9ydCAvb3JnL2JsdWV6Lzc4
OTgvaGNpMC9kZXZfMDBfMjNfN0ZfMkJfNTRfQUMvZmQ4OiB3cml0ZSBsb2NrIHJlbGVhc2VkCkp1
bCAxMiAyMToyNToyOSBwZXRlciBibHVldG9vdGhkWzc4OThdOiBhdWRpby90cmFuc3BvcnQuYzpt
ZWRpYV9yZXF1ZXN0X3JlcGx5KCkgUmVxdWVzdCBBY3F1aXJlIFJlcGx5IElucHV0L291dHB1dCBl
cnJvcgpKdWwgMTIgMjE6MjU6MjkgcGV0ZXIgYmx1ZXRvb3RoZFs3ODk4XTogYXVkaW8vdHJhbnNw
b3J0LmM6bWVkaWFfb3duZXJfZnJlZSgpIE93bmVyIDoxLjUyOApKdWwgMTIgMjE6MjU6MjkgcGV0
ZXIgYmx1ZXRvb3RoZFs3ODk4XTogYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfb3duZXJfcmVtb3Zl
KCkgT3duZXIgOjEuNTI4IFJlcXVlc3QgQWNxdWlyZQoK
--=====================_4320078==_--

