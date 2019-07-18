Return-Path: <SRS0=wIos=VP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46797C7618F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 21:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F227F2173B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 21:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIVPxTZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfGRVEX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:04:23 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:45627 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRVEX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jul 2019 17:04:23 -0400
Received: by mail-yb1-f172.google.com with SMTP id s41so9114883ybe.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2019 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PmQIRFbOoiqfW6WFCk6HkCrL09SCrEYJXCensd6atjU=;
        b=vIVPxTZFFUjVZznc+bECAqtyn3kMBXeXg/Qop8ib0c5qeB+Ip7dv+VsBnNGt4Gijxi
         zvMo28Eatkd+Dw1gwWv5YsnH6ujKWSbLABuGbtOEYGZ68QU7ZqRKqSBm9iZVaJTJAkqs
         4HXpLsaHJqylaDKE+oVV6psfvy1m6w0ptFnLZ0OR5DgruxfFA8jxK88RSBjGY+5JhbrY
         psqKuuWwdH7epgpdvlk08aT+ucV/zJ13c0Po6dwEZVX5bifidtouxVVqMxAZBv26AljE
         9APx9hYxFOyZKEY3/k0pjvADhcKU+YTtotPTisGAtw+9PfvI7itzZCmyJUgi0wfuKevc
         HK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PmQIRFbOoiqfW6WFCk6HkCrL09SCrEYJXCensd6atjU=;
        b=BVhTRZzNCM7N9Qt7ADXWuz9G2uxxkJuArcrQo40rSoSNhZThoGeIvOm0If7Bm8eSwm
         kI1UmeCXnJ0QWEyrChWv8G+sVDwfhcnt/5MQLVANhfSezkKdOI+F0lVZKP7QPdmJl/Za
         OrisL/wlMn90SG44l+54ZZO3HdzzxaJr7YlCoT7fqRxC36pbm0Cj7xnhypYN7wDAD4wR
         JNN5sMeMGURzbCdAyjMmLR8+YrcZerwSSBF0LZ0rB7HfRYEtJX/kIc4gy5M+lSnQL5lM
         ZwDwBhReVm3HKz5rtVj3+pekRIgkQ+E9GufPYXk07HVExzkqYbDyTlWo03JVUR83Fcbz
         H4QA==
X-Gm-Message-State: APjAAAXMZxGCTC0EasT7yXgyquRufWUK3v+HObdloyC2g6t6ZLBoNtZ7
        HGGf0SreQhydPYECKmOlP+P7JEIbTB0VRKSMLW50QQ6V
X-Google-Smtp-Source: APXvYqwVEyl+ft6rICf3ZtoVxZGYmgDno4ICROS7FFs/TjhkDZ2eAEUJnpDeko7Rr8fJLE0Yvz3zJXkG1ldNIFHrMvk=
X-Received: by 2002:a25:6756:: with SMTP id b83mr29433993ybc.37.1563483861473;
 Thu, 18 Jul 2019 14:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAAu3APas5syS3gYXN-BBqB=OcDZJjpPwND6qzOO1wSmbMq2U1Q@mail.gmail.com>
 <CABBYNZ+W8dG7qgAe-2QYnSkyVG_1eA4KtMKHyXws0LWwB346Ow@mail.gmail.com>
In-Reply-To: <CABBYNZ+W8dG7qgAe-2QYnSkyVG_1eA4KtMKHyXws0LWwB346Ow@mail.gmail.com>
From:   Barry Byford <31baz66@gmail.com>
Date:   Thu, 18 Jul 2019 22:04:06 +0100
Message-ID: <CAAu3APaPaDXBNsWcCUhNF2_sM_AxiKe5B6U1xtMOU9tYwpFS2g@mail.gmail.com>
Subject: Re: DBus LEAdvertisement and Python
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

Thanks for the prompt response. Below are some updates following your input.

On Thu, 18 Jul 2019 at 09:26, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Barry,
>
> On Thu, Jul 18, 2019 at 10:03 AM Barry Byford <31baz66@gmail.com> wrote:
> >
> > Hello,
> >
> > The Python examples provided in the test directory of the BlueZ
> > repository use the python-dbus library. Looking at the documentation
> > of that library it does start by raising concerns and offering
> > alternatives. I have been looking at some of the alternatives and am
> > having difficultly getting them to work with BlueZ. I have been
> > focusing on the org.bluez.LEAdvertisement1 interface.
> >
> > Looking at the documentation, it says the service, interface and
> > object details are:
> > Service org.bluez
> > Interface org.bluez.LEAdvertisement1
> > Object path freely definable
> >
> > I am not being successful at publishing to the org.bluez service. It
> > is also not where the current examples publish to.
> > Looking at the GattProfile1 documentation, it has service and object
> > as application dependant.
> > Service <application dependent>
> > Interface org.bluez.GattProfile1
> > Object path <application dependent>
> > Should the documentation of Service on LEAdvertisement1 be freely
> > definable also?
>
> Yep, the bus name is up to the application which usually don't
> register a friendly name if you try to register with 'org.bluez' it
> would probably conflict with the daemon itself so you wouldn't be able
> to register that name anyway.
>
> > I have created the LEAdvertisement1 interface so that it has an
> > ObjectManager and is introspectable. When I pass the object to
> > RegisterAdvertisement on the org.bluez.LEAdvertisingManager1 interface
> > it accepts it (does not give an error) but does not register the data
> > and I see no advertisement appear. Is there somewhere I can find a
> > more detailed description of what needs to be on the
> > org.bluez.LEAdvertisement1 interface that will work with
> > RegisterAdvertisement?
>
> Do you have the bluetoothd output when you register, I get the
> following when using bluetoothctl:
>
> bluetooth]# power on
> Changing power on succeeded
> [bluetooth]# advertise on
> [CHG] Controller B8:8A:60:D8:17:D7 SupportedInstances: 0x04
> [CHG] Controller B8:8A:60:D8:17:D7 ActiveInstances: 0x01
> Advertising object registered
> Tx Power: off
> Name: off
> Apperance: off
> Discoverable: off
> [bluetooth]#

Using the new dbus library I get:
Log from bluetoothctl:
[CHG] Controller FC:F8:AE:8F:0C:A4 SupportedInstances: 0x04
[CHG] Controller FC:F8:AE:8F:0C:A4 ActiveInstances: 0x01

From the bluetoothd log:
bluetoothd[2856]: src/advertising.c:register_advertisement()
RegisterAdvertisement
bluetoothd[2856]: src/advertising.c:client_create() Adding proxy for
/ukBaz/bluezero/advertisement1
bluetoothd[2856]: src/advertising.c:register_advertisement()
Registered advertisement at path /ukBaz/bluezero/advertisement1
bluetoothd[2856]: src/advertising.c:refresh_adv() Refreshing
advertisement: /ukBaz/bluezero/advertisement1
bluetoothd[2856]: src/advertising.c:add_adv_callback() Advertisement
registered: /ukBaz/bluezero/advertisement1


With the old pyton-dbus library (that is working) I get:
log from bluetoothctl:
[CHG] Controller FC:F8:AE:8F:0C:A4 SupportedInstances: 0x04
[CHG] Controller FC:F8:AE:8F:0C:A4 ActiveInstances: 0x01

From the bluetoothd log:
bluetoothd[2856]: src/advertising.c:register_advertisement()
RegisterAdvertisement
bluetoothd[2856]: src/advertising.c:client_create() Adding proxy for
/ukBaz/bluezero/advertisement0001
bluetoothd[2856]: src/advertising.c:register_advertisement()
Registered advertisement at path /ukBaz/bluezero/advertisement0001
bluetoothd[2856]: src/advertising.c:parse_service_uuids() Adding
ServiceUUID: FEAA
bluetoothd[2856]: src/advertising.c:parse_service_data() Adding
ServiceData for FEAA
bluetoothd[2856]: src/advertising.c:refresh_adv() Refreshing
advertisement: /ukBaz/bluezero/advertisement0001
bluetoothd[2856]: src/advertising.c:add_adv_callback() Advertisement
registered: /ukBaz/bluezero/advertisement0001


>
> bluetoothd[6103]: src/advertising.c:client_create() Adding proxy for
> /org/bluez/advertising
> bluetoothd[6103]: src/advertising.c:register_advertisement()
> Registered advertisement at path /org/bluez/advertising
> bluetoothd[6103]: src/advertising.c:refresh_adv() Refreshing
> advertisement: /org/bluez/advertising
> bluetoothd[6103]: src/advertising.c:add_adv_callback() Advertisement
> registered: /org/bluez/advertising
>
>
> > For reference, I have put below what I am currently  putting on the
> > org.bluez.LEAdvertisement1 interface.
> >
> > Thanks,
> > Barry
> >
> >
> > $ busctl call ukBaz.bluezero /ukBaz/bluezero/advertisement1
> > org.freedesktop.DBus.ObjectManager GetManagedObjects
> > a{oa{sa{sv}}} 1 "/ukBaz/bluezero/advertisement1" 5
> > "org.freedesktop.DBus.Properties" 0
> > "org.freedesktop.DBus.Introspectable" 0 "org.freedesktop.DBus.Peer" 0
> > "org.freedesktop.DBus.ObjectManager" 0 "org.bluez.LEAdvertisement1" 6
> > "Type" s "broadcast" "ServiceUUIDs" as 0 "ManufacturerData" a{sv} 0
> > "SolicitUUIDs" as 0 "ServiceData" a{sv} 1 "FEAA" ay 18 16 8 3 117 107
> > 66 97 122 46 103 105 116 104 117 98 46 105 111 "IncludeTxPower" b
> > false
>
> Not sure if that is the problem but usually ObjectManager is suppose
> to be on the '/' (root) path.

Good point. It is not clear (to me anyway) exactly what the
requirement is from reading the spec
https://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager
I have moved the object manager to the root (/) but this does not seem
to have changed anything.

$ busctl call ukBaz.bluezero / org.freedesktop.DBus.ObjectManager
GetManagedObjects
a{oa{sa{sv}}} 1 "/ukBaz/bluezero/advertisement1" 4
"org.freedesktop.DBus.Properties" 0
"org.freedesktop.DBus.Introspectable" 0 "org.freedesktop.DBus.Peer" 0
"org.bluez.LEAdvertisement1" 6 "Type" s "broadcast" "ServiceUUIDs" as
0 "ManufacturerData" a{sv} 0 "SolicitUUIDs" as 0 "ServiceData" a{sv} 1
"FEAA" ay 18 16 8 3 117 107 66 97 122 46 103 105 116 104 117 98 46 105
111 "IncludeTxPower" b false


>
> > $ busctl call ukBaz.bluezero /ukBaz/bluezero/advertisement1
> > org.freedesktop.DBus.Properties GetAll s org.bluez.LEAdvertisement1
> > a{sv} 6 "Type" s "broadcast" "ServiceUUIDs" as 0 "ManufacturerData"
> > a{sv} 0 "SolicitUUIDs" as 0 "ServiceData" a{sv} 1 "FEAA" ay 18 16 8 3
> > 117 107 66 97 122 46 103 105 116 104 117 98 46 105 111
> > "IncludeTxPower" b false
> >

Using the d-feet application I did a GetAll on the advertisements and
the data looks identical for both
Using the new DBus library:
{'IncludeTxPower': False,
 'ManufacturerData': {},
 'ServiceData': {'FEAA': [16,
                          8,
                          3,
                          117,
                          107,
                          66,
                          97,
                          122,
                          46,
                          103,
                          105,
                          116,
                          104,
                          117,
                          98,
                          46,
                          105,
                          111]},
 'ServiceUUIDs': ['FEAA'],
 'SolicitUUIDs': [],
 'Type': 'broadcast'}

Using the old Python-dbus library:
{'IncludeTxPower': False,
 'ServiceData': {'FEAA': [16,
                          8,
                          3,
                          117,
                          107,
                          66,
                          97,
                          122,
                          46,
                          103,
                          105,
                          116,
                          104,
                          117,
                          98,
                          46,
                          105,
                          111]},
 'ServiceUUIDs': ['FEAA'],
 'Type': 'broadcast'}

> > $ busctl call ukBaz.bluezero /ukBaz/bluezero/advertisement1
> > org.freedesktop.DBus.Introspectable Introspect
> > s "<!DOCTYPE node PUBLIC \"-//freedesktop//DTD D-BUS Object
> > Introspection 1.0//EN\"\n
> > \"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd\">\n<!--
> > GDBus 2.60.4 -->\n<node>\n  <interface
> > name=\"org.freedesktop.DBus.Properties\">\n    <method name=\"Get\">\n
> >      <arg type=\"s\" name=\"interface_name\" direction=\"in\"/>\n
> > <arg type=\"s\" name=\"property_name\" direction=\"in\"/>\n      <arg
> > type=\"v\" name=\"value\" direction=\"out\"/>\n    </method>\n
> > <method name=\"GetAll\">\n      <arg type=\"s\"
> > name=\"interface_name\" direction=\"in\"/>\n      <arg type=\"a{sv}\"
> > name=\"properties\" direction=\"out\"/>\n    </method>\n    <method
> > name=\"Set\">\n      <arg type=\"s\" name=\"interface_name\"
> > direction=\"in\"/>\n      <arg type=\"s\" name=\"property_name\"
> > direction=\"in\"/>\n      <arg type=\"v\" name=\"value\"
> > direction=\"in\"/>\n    </method>\n    <signal
> > name=\"PropertiesChanged\">\n      <arg type=\"s\"
> > name=\"interface_name\"/>\n      <arg type=\"a{sv}\"
> > name=\"changed_properties\"/>\n      <arg type=\"as\"
> > name=\"invalidated_properties\"/>\n    </signal>\n  </interface>\n
> > <interface name=\"org.freedesktop.DBus.Introspectable\">\n    <method
> > name=\"Introspect\">\n      <arg type=\"s\" name=\"xml_data\"
> > direction=\"out\"/>\n    </method>\n  </interface>\n  <interface
> > name=\"org.freedesktop.DBus.Peer\">\n    <method name=\"Ping\"/>\n
> > <method name=\"GetMachineId\">\n      <arg type=\"s\"
> > name=\"machine_uuid\" direction=\"out\"/>\n    </method>\n
> > </interface>\n  <interface
> > name=\"org.freedesktop.DBus.ObjectManager\">\n    <method
> > name=\"GetManagedObjects\">\n      <arg type=\"a{oa{sa{sv}}}\"
> > name=\"object_paths_interfaces_and_properties\" direction=\"out\">\n
> >    </arg>\n    </method>\n    <signal name=\"InterfacesAdded\">\n
> > <arg type=\"o\" name=\"object_path\">\n      </arg>\n      <arg
> > type=\"a{sa{sv}}\" name=\"interfaces_and_properties\">\n      </arg>\n
> >    </signal>\n    <signal name=\"InterfacesRemoved\">\n      <arg
> > type=\"o\" name=\"object_path\">\n      </arg>\n      <arg type=\"as\"
> > name=\"interfaces\">\n      </arg>\n    </signal>\n  </interface>\n
> > <interface name=\"org.bluez.LEAdvertisement1\">\n    <annotation
> > name=\"org.freedesktop.DBus.Properties.PropertiesChanged\"
> > value=\"const\">\n    </annotation>\n    <method name=\"Release\">\n
> >    <annotation name=\"org.freedesktop.DBus.Method.NoReply\"
> > value=\"true\">\n      </annotation>\n    </method>\n    <property
> > type=\"s\" name=\"Type\" access=\"read\">\n    </property>\n
> > <property type=\"as\" name=\"ServiceUUIDs\" access=\"read\">\n
> > </property>\n    <property type=\"a{sv}\" name=\"ManufacturerData\"
> > access=\"read\">\n    </property>\n    <property type=\"as\"
> > name=\"SolicitUUIDs\" access=\"read\">\n    </property>\n    <property
> > type=\"a{sv}\" name=\"ServiceData\" access=\"read\">\n
> > </property>\n    <property type=\"b\" name=\"IncludeTxPower\"
> > access=\"read\">\n    </property>\n  </interface>\n</node>\n"
>
>
>
> --
> Luiz Augusto von Dentz
