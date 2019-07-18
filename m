Return-Path: <SRS0=wIos=VP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1A5C76191
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 07:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC232173B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 07:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN7zpI6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfGRHAh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:00:37 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:40576 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfGRHAh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jul 2019 03:00:37 -0400
Received: by mail-yw1-f49.google.com with SMTP id b143so11842167ywb.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2019 00:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dGxY0lboZcKzqkPUreqNjAwx1aSMJbFVJrytYGXt7XI=;
        b=JN7zpI6y2xKLCGrQta3WrBIqYkrLF640L49S+dubvJd9pz8WQrRxOnu/rAnKxXyAYt
         hWmUcHGgi0FQBfN3GqrUC02TrRn6pcTVRx9VKfXy/Hi6XCPLQdLq8WdiB19yyqzIJy6M
         2cVC+XNTGJYx6MQWP0vCSkz4SUHwz8g76mr7q/1hJ0dsaF1GByv7EWZQSgcs1QSCGugp
         v7gfrX28pEsHi8OpD2YMupStDX3YV4O8gz9Wx9SYWv4V3NcQM0nY/253cNXZZ/GobySR
         /+/iybFz5h++40dEj3Qm6kRu3GqOg609vZftCH/72Cq24T9jBqyeNa8yZEtZARZ6RuJr
         BWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dGxY0lboZcKzqkPUreqNjAwx1aSMJbFVJrytYGXt7XI=;
        b=GhdZTf+3obgsdFkwyxDYBlj4Xug2dvrhwcgi11VWaEUAtBEw+nJY2Ai9vRezfDxJYe
         9KziaOk3qVjR1Vs1SSH2Jc9D5OVZ5ky4uMlZD4OBLQ7MurROvqAulBBg9+2pnQzwh1IF
         1qDAlWe7/DOPHKAsISYOdZQvia8y7EkHhbFp2Q5eLKERwBenjaGTr87sUSIWQI0Z1w1S
         a/s253huq+drOG+Su6MTqDwHl1WaM7qgqCt9+DwY+d4LiujENcU/CRGo4QzJpEFaVq12
         e7AXlzPRglNavfwy/bApqJANObGao7YcUS5fnO39kkC2wkpzgcyfEQuMI9ebXNKN9ILN
         I8oA==
X-Gm-Message-State: APjAAAXUuMS26wxCXL5av6icFjj2mZ772iXzo0gHsa1FHD5QYM4kBESt
        YGO8e6yNNI29QZX+lYhpcRj4SPBNbpfy423u9vdhz4P1
X-Google-Smtp-Source: APXvYqyWdzhrulEMvQxvs1OR2AJcqNCGTD1FeusTlHnm3uJ0BfQvs790n3Br3vN1qYYvvp7Z0JufbF3nbJFLhxsHoZo=
X-Received: by 2002:a81:2843:: with SMTP id o64mr25151430ywo.113.1563433236022;
 Thu, 18 Jul 2019 00:00:36 -0700 (PDT)
MIME-Version: 1.0
From:   Barry Byford <31baz66@gmail.com>
Date:   Thu, 18 Jul 2019 08:00:24 +0100
Message-ID: <CAAu3APas5syS3gYXN-BBqB=OcDZJjpPwND6qzOO1wSmbMq2U1Q@mail.gmail.com>
Subject: DBus LEAdvertisement and Python
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

The Python examples provided in the test directory of the BlueZ
repository use the python-dbus library. Looking at the documentation
of that library it does start by raising concerns and offering
alternatives. I have been looking at some of the alternatives and am
having difficultly getting them to work with BlueZ. I have been
focusing on the org.bluez.LEAdvertisement1 interface.

Looking at the documentation, it says the service, interface and
object details are:
Service org.bluez
Interface org.bluez.LEAdvertisement1
Object path freely definable

I am not being successful at publishing to the org.bluez service. It
is also not where the current examples publish to.
Looking at the GattProfile1 documentation, it has service and object
as application dependant.
Service <application dependent>
Interface org.bluez.GattProfile1
Object path <application dependent>
Should the documentation of Service on LEAdvertisement1 be freely
definable also?

I have created the LEAdvertisement1 interface so that it has an
ObjectManager and is introspectable. When I pass the object to
RegisterAdvertisement on the org.bluez.LEAdvertisingManager1 interface
it accepts it (does not give an error) but does not register the data
and I see no advertisement appear. Is there somewhere I can find a
more detailed description of what needs to be on the
org.bluez.LEAdvertisement1 interface that will work with
RegisterAdvertisement?

For reference, I have put below what I am currently  putting on the
org.bluez.LEAdvertisement1 interface.

Thanks,
Barry


$ busctl call ukBaz.bluezero /ukBaz/bluezero/advertisement1
org.freedesktop.DBus.ObjectManager GetManagedObjects
a{oa{sa{sv}}} 1 "/ukBaz/bluezero/advertisement1" 5
"org.freedesktop.DBus.Properties" 0
"org.freedesktop.DBus.Introspectable" 0 "org.freedesktop.DBus.Peer" 0
"org.freedesktop.DBus.ObjectManager" 0 "org.bluez.LEAdvertisement1" 6
"Type" s "broadcast" "ServiceUUIDs" as 0 "ManufacturerData" a{sv} 0
"SolicitUUIDs" as 0 "ServiceData" a{sv} 1 "FEAA" ay 18 16 8 3 117 107
66 97 122 46 103 105 116 104 117 98 46 105 111 "IncludeTxPower" b
false

$ busctl call ukBaz.bluezero /ukBaz/bluezero/advertisement1
org.freedesktop.DBus.Properties GetAll s org.bluez.LEAdvertisement1
a{sv} 6 "Type" s "broadcast" "ServiceUUIDs" as 0 "ManufacturerData"
a{sv} 0 "SolicitUUIDs" as 0 "ServiceData" a{sv} 1 "FEAA" ay 18 16 8 3
117 107 66 97 122 46 103 105 116 104 117 98 46 105 111
"IncludeTxPower" b false

$ busctl call ukBaz.bluezero /ukBaz/bluezero/advertisement1
org.freedesktop.DBus.Introspectable Introspect
s "<!DOCTYPE node PUBLIC \"-//freedesktop//DTD D-BUS Object
Introspection 1.0//EN\"\n
\"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd\">\n<!--
GDBus 2.60.4 -->\n<node>\n  <interface
name=\"org.freedesktop.DBus.Properties\">\n    <method name=\"Get\">\n
     <arg type=\"s\" name=\"interface_name\" direction=\"in\"/>\n
<arg type=\"s\" name=\"property_name\" direction=\"in\"/>\n      <arg
type=\"v\" name=\"value\" direction=\"out\"/>\n    </method>\n
<method name=\"GetAll\">\n      <arg type=\"s\"
name=\"interface_name\" direction=\"in\"/>\n      <arg type=\"a{sv}\"
name=\"properties\" direction=\"out\"/>\n    </method>\n    <method
name=\"Set\">\n      <arg type=\"s\" name=\"interface_name\"
direction=\"in\"/>\n      <arg type=\"s\" name=\"property_name\"
direction=\"in\"/>\n      <arg type=\"v\" name=\"value\"
direction=\"in\"/>\n    </method>\n    <signal
name=\"PropertiesChanged\">\n      <arg type=\"s\"
name=\"interface_name\"/>\n      <arg type=\"a{sv}\"
name=\"changed_properties\"/>\n      <arg type=\"as\"
name=\"invalidated_properties\"/>\n    </signal>\n  </interface>\n
<interface name=\"org.freedesktop.DBus.Introspectable\">\n    <method
name=\"Introspect\">\n      <arg type=\"s\" name=\"xml_data\"
direction=\"out\"/>\n    </method>\n  </interface>\n  <interface
name=\"org.freedesktop.DBus.Peer\">\n    <method name=\"Ping\"/>\n
<method name=\"GetMachineId\">\n      <arg type=\"s\"
name=\"machine_uuid\" direction=\"out\"/>\n    </method>\n
</interface>\n  <interface
name=\"org.freedesktop.DBus.ObjectManager\">\n    <method
name=\"GetManagedObjects\">\n      <arg type=\"a{oa{sa{sv}}}\"
name=\"object_paths_interfaces_and_properties\" direction=\"out\">\n
   </arg>\n    </method>\n    <signal name=\"InterfacesAdded\">\n
<arg type=\"o\" name=\"object_path\">\n      </arg>\n      <arg
type=\"a{sa{sv}}\" name=\"interfaces_and_properties\">\n      </arg>\n
   </signal>\n    <signal name=\"InterfacesRemoved\">\n      <arg
type=\"o\" name=\"object_path\">\n      </arg>\n      <arg type=\"as\"
name=\"interfaces\">\n      </arg>\n    </signal>\n  </interface>\n
<interface name=\"org.bluez.LEAdvertisement1\">\n    <annotation
name=\"org.freedesktop.DBus.Properties.PropertiesChanged\"
value=\"const\">\n    </annotation>\n    <method name=\"Release\">\n
   <annotation name=\"org.freedesktop.DBus.Method.NoReply\"
value=\"true\">\n      </annotation>\n    </method>\n    <property
type=\"s\" name=\"Type\" access=\"read\">\n    </property>\n
<property type=\"as\" name=\"ServiceUUIDs\" access=\"read\">\n
</property>\n    <property type=\"a{sv}\" name=\"ManufacturerData\"
access=\"read\">\n    </property>\n    <property type=\"as\"
name=\"SolicitUUIDs\" access=\"read\">\n    </property>\n    <property
type=\"a{sv}\" name=\"ServiceData\" access=\"read\">\n
</property>\n    <property type=\"b\" name=\"IncludeTxPower\"
access=\"read\">\n    </property>\n  </interface>\n</node>\n"
