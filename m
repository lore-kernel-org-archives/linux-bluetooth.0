Return-Path: <SRS0=SE7D=N2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71660C43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 17:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B93A2086C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 17:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShJepvxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B93A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbeKPDT1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:19:27 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:40934 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbeKPDT0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Nov 2018 22:19:26 -0500
Received: by mail-it1-f172.google.com with SMTP id e11so30309012itl.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Nov 2018 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wvNP3f91LKwp0DqgQPZLNIaKws4haHiuU3S39mH6/8Y=;
        b=ShJepvxcLlLugsE7StfUdgdkFlMvDkkA4viyyxwrjW0Bw+1lfoVLcRvbTeglizqZfc
         yqenZ1nfgZnI8euW/IG3B/y94D945lxhDjo63EGll0VZyr8lSkue+knaU9WMGBaeBLvs
         vZNe80Dy8N1ChBrR7Qq4n0mPGPdBhusPwKbsL3fr8fj4dAFgGUIltYmyPsQLMo2jE+H2
         t91ZRiOl6gMRQUMkTUiI9ZbjLQ5JswIL6AHQEVZVn1iHV08q/DGh6uaTcoM1bNUeau8Q
         UpR2WPdvwwmCaFiJv8HC226ALyBsmEUgxug5OZrX/tt1F3v0bfGRey2umOURb3W/4hO+
         cDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wvNP3f91LKwp0DqgQPZLNIaKws4haHiuU3S39mH6/8Y=;
        b=EJcohFATUhtrHutJI50rjlcJaJAxIEvlN0bmtsZp+kVi53Itaxge/MGdSORQ+ZqOzI
         5GdZ3ovz+lzElsfzsLW/29WLBmeReTNG5tOCP9+xE4GA7JL/Z4WsZQ3Vvq/Y2FgfgGIG
         EGR2l7oXrttDnsBlxWqBX8qrFsfYAQh/r0uqfgNym4vkBl1c/vr7JSQ+QnCnkzPjUzAS
         3uDRg0AdpfuEUam4KD2FHtiOSBIA7vOlTgG+01gPsizqSEJmIAPJlH43W1NtRXizt6at
         MTiVCppC8SlO1IMWZKJ1AKsziSYVFJK78JaXJmuX827SBHDbgwgsJft5bWziVlaJ+wUc
         YWOw==
X-Gm-Message-State: AA+aEWaAOnK+FKzAu3TRdwbd7Qo/kHhxf4J2S6jnEUeO4UvYH2oDUTL7
        KI2PucyO9FGb56bGdQ7aJv79Kpoqw70NkljGlu5dhGTF
X-Google-Smtp-Source: AJdET5dk4JgchALQgzd1pLvsWoia2OqxU/35A7OX/pg9/5iVnmIc4FdgTXk2n4Pbw/PV3iv0buLEmYppyK6g8901Ops=
X-Received: by 2002:a24:5284:: with SMTP id d126mr1972656itb.91.1542301846848;
 Thu, 15 Nov 2018 09:10:46 -0800 (PST)
MIME-Version: 1.0
References: <CABatt_x1aNftgFVuDxrhyZVs4bGmOZFccjPKU_BpfbGmMWTazA@mail.gmail.com>
 <CABatt_zHbVz+cbb6Vig820W5bdXd+Cd1Jjh02MdqnBiX0WQuEg@mail.gmail.com>
 <CABBYNZJ0uT-qX2njVfFan2vVWaEveDR+waOC3FSZrTfpaBkHew@mail.gmail.com>
 <CABatt_wSMSiW+Fmi5cccAnejMbAAHdNWb-jW0qLcijtdWETHzw@mail.gmail.com>
 <CABatt_yhozRuFjtSsmvHJNyFoFR7tstfuZp9jPdcZpxuCx7z=A@mail.gmail.com>
 <CABatt_zEv6Cksm5buiaiacOdxY4nurmbiX2OdPuQYjqUDKkRCw@mail.gmail.com>
 <CAO1O6sdawagz6nfL0J=4EZ7YbLGUd2YmMbiJZVqd-BtyqLN0GA@mail.gmail.com>
 <CABBYNZJJoLbWC5Dm3Gmd23TdFG1KJQUUKL4e+hGit4CzM5Rp5w@mail.gmail.com> <CABatt_wXV6==NNsqogs_Pk1eHqu3uqeietiEn+pKdwM3d5zCWg@mail.gmail.com>
In-Reply-To: <CABatt_wXV6==NNsqogs_Pk1eHqu3uqeietiEn+pKdwM3d5zCWg@mail.gmail.com>
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Thu, 15 Nov 2018 17:10:35 +0000
Message-ID: <CABatt_xTXOUOZuE-jLaSnnFy7ydfAYE05s1rc4Y8RLXD+v6WXw@mail.gmail.com>
Subject: Re: Operating central and peripheral roles concurrently
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     emil.lenngren@gmail.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Nov 15, 2018 at 4:54 PM Martin Townsend <mtownsend1973@gmail.com> w=
rote:
>
> On Tue, Nov 13, 2018 at 11:21 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Emil, Martin,
> > On Tue, Nov 13, 2018 at 12:47 PM Emil Lenngren <emil.lenngren@gmail.com=
> wrote:
> > >
> > > Hi,
> > >
> > > Den m=C3=A5n 12 nov. 2018 kl 17:19 skrev Martin Townsend <mtownsend19=
73@gmail.com>:
> > > > I've just been reading the 4.1 spec on GAP and on page 224 it state=
s:
> > > >
> > > >
> > > > "In LE, GAP defines four specific roles: Broadcaster, Observer, Per=
ipheral, and
> > > > Central. A device may support multiple LE GAP roles provided that t=
he underly-
> > > > ing Controller supports those roles or role combinations. However, =
only one LE
> > > > GAP role may be supported at a given time. Each role specifies the =
require-
> > > > ments for the underlying Controller. This allows for Controllers to=
 be optimized
> > > > for specific use cases."
> > > >
> > > > Now to me that says a device can support being a central and
> > > > peripheral but doesn't have to support them concurrently so I'm
> > > > guessing if the device is in the peripheral role and then wanted to
> > > > connect to another device you would have to stop being a peripheral
> > > > (ie drop this connection) and then become a central, make the
> > > > connection and when finished disconnect and become a peripheral aga=
in
> > > > and wait for the other devices to reconnect to you.  Or am I
> > > > mis-reading this?
> > >
> > > This restriction is lifted in newer versions of the spec. The same
> > > section in version 4.2 says this:
> > > "In LE, GAP defines four specific roles: Broadcaster, Observer, Perip=
heral, and
> > > Central. A device may support multiple LE GAP roles provided that the
> > > underlying Controller supports those roles or role combinations. Each=
 role
> > > specifies the requirements for the underlying Controller. This allows=
 for
> > > Controllers to be optimized for specific use cases."
> > >
> > > If you use the btmon tool you can easily see what combination of
> > > supported states the controller supports. If you have btmon running
> > > while you initiate bluetoothd you will see the packet LE Read
> > > Supported States Command, which contains this info.
> >
> > In that case we should definitely use these states to determine
> > instead of assuming the controller don't support Master & Slave state,
> > though it would be great if Martin provides the HCI traces where it is
> > failing and if indeed is the controller not support it or some other
> > bug.
> >
> > --
> > Luiz Augusto von Dentz
>
> Apologies for the delay.  I've heard back from the device manufacture
> and they have confirmed that it does support both roles simultaneously
> and have proved this using their WICED platform.
> https://community.cypress.com/thread/36729
>
> So I have ran btmon and then powered the device and get the following
> LE Read Supported States message in the log (let me know if you want
> the full log or other messages, there were quite a few of them)
>
> < HCI Command: LE Read Supported States (0x08|0x001c) plen 0
>                            #27 [hci0] 12.173109
> > HCI Event: Command Complete (0x0e) plen 12                             =
                         #28 [hci0] 12.178836
>       LE Read Supported States (0x08|0x001c) ncmd 1
>         Status: Success (0x00)
>         States: 0x000003ffffffffff
>           Non-connectable Advertising State
>           Scannable Advertising State
>           Connectable Advertising State
>           High Duty Cycle Directed Advertising State
>           Passive Scanning State
>           Active Scanning State
>           Initiating State
>             and Connection State (Master Role)
>           Connection State (Slave Role)
>           Non-connectable Advertising State
>             and Passive Scanning State
>           Scannable Advertising State
>             and Passive Scanning State
>           Connectable Advertising State
>             and Passive Scanning State
>           High Duty Cycle Directed Advertising State
>             and Passive Scanning State
>           Non-connectable Advertising State
>             and Active Scanning State
>           Scannable Advertising State
>             and Active Scanning State
>           Connectable Advertising State
>             and Active Scanning State
>           High Duty Cycle Directed Advertising State
>             and Active Scanning State
>           Non-connectable Advertising State
>             and Initiating State
>           Scannable Advertising State
>             and Initiating State
>           Non-connectable Advertising State
>             and Connection State (Master Role)
>           Scannable Advertising State
>             and Connection State (Master Role)
>           Non-connectable Advertising State
>             and Connection State (Slave Role)
>           Scannable Advertising State
>             and Connection State (Slave Role)
>           Passive Scanning State
>             and Initiating State
>           Active Scanning State
>             and Initiating State
>           Passive Scanning State
>             and Connection State (Master Role)
>           Active Scanning State
>             and Connection State (Master Role)
>           Passive Scanning State
>             and Connection State (Slave Role)
>           Active Scanning State
>             and Connection State (Slave Role)
>           Initiating State
>             and Connection State (Master Role)
>             and Master Role & Master Role
>           Low Duty Cycle Directed Advertising State
>           Low Duty Cycle Directed Advertising State
>             and Passive Scanning State
>           Low Duty Cycle Directed Advertising State
>             and Active Scanning State
>           Connectable Advertising State
>             and Initiating State
>             and Master Role & Slave Role
>           High Duty Cycle Directed Advertising State
>             and Initiating State
>             and Master Role & Slave Role
>           Low Duty Cycle Directed Advertising State
>             and Initiating State
>             and Master Role & Slave Role
>           Connectable Advertising State
>             and Connection State (Master Role)
>             and Master Role & Slave Role
>           High Duty Cycle Directed Advertising State
>             and Connection State (Master Role)
>             and Master Role & Slave Role
>           Low Duty Cycle Directed Advertising State
>             and Connection State (Master Role)
>             and Master Role & Slave Role
>           Connectable Advertising State
>             and Connection State (Slave Role)
>             and Master Role & Slave Role
>           High Duty Cycle Directed Advertising State
>             and Connection State (Slave Role)
>             and Slave Role & Slave Role
>           Low Duty Cycle Directed Advertising State
>             and Connection State (Slave Role)
>             and Slave Role & Slave Role
>           Initiating State
>             and Connection State (Slave Role)
>             and Master Role & Slave Role
>
> Using btmon I then captured the HCI trace for the failing dual role case
>
> Starting the GATT Server and connecting from a PC
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> < HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15
>                           #69 [hci0] 736.868434
>         Min advertising interval: 1280.000 msec (0x0800)
>         Max advertising interval: 1280.000 msec (0x0800)
>         Type: Connectable undirected - ADV_IND (0x00)
>         Own address type: Public (0x00)
>         Direct address type: Public (0x00)
>         Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>         Channel map: 37, 38, 39 (0x07)
>         Filter policy: Allow Scan Request from Any, Allow Connect
> Request from Any (0x00)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                        #70 [hci0] 736.875133
>       LE Set Advertising Parameters (0x08|0x0006) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
>                           #71 [hci0] 736.878291
>         Advertising: Enabled (0x01)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                        #72 [hci0] 736.883585
>       LE Set Advertise Enable (0x08|0x000a) ncmd 1
>         Status: Success (0x00)
> @ RAW Close: hciconfig
>                      {0x0004} [hci0] 736.884982
> @ RAW Close: hciconfig
>                             {0x0003} 736.885139
> @ RAW Open: btgatt-server (privileged) version 2.22
>                             {0x0003} 736.950116
> @ RAW Close: btgatt-server
>                             {0x0003} 736.953288
> @ RAW Open: btgatt-server (privileged) version 2.22
>                             {0x0003} 736.953693
> @ RAW Close: btgatt-server
>                             {0x0003} 736.953991
> > HCI Event: LE Meta Event (0x3e) plen 19                                =
                        #73 [hci0] 752.270109
>       LE Connection Complete (0x01)
>         Status: Success (0x00)
>         Handle: 64
>         Role: Slave (0x01)
>         Peer address type: Public (0x00)
>         Peer address: 9C:B6:D0:DE:5C:A2 (OUI 9C-B6-D0)
>         Connection interval: 45.00 msec (0x0024)
>         Connection latency: 0 (0x0000)
>         Supervision timeout: 420 msec (0x002a)
>         Master clock accuracy: 0x00
> @ MGMT Event: Device Connected (0x000b) plen 13
>                      {0x0001} [hci0] 752.270401
>         LE Address: 9C:B6:D0:DE:5C:A2 (OUI 9C-B6-D0)
>         Flags: 0x00000000
>         Data length: 0
> @ MGMT Event: Device Connected (0x000b) plen 13
>                      {0x0002} [hci0] 752.270401
>         LE Address: 9C:B6:D0:DE:5C:A2 (OUI 9C-B6-D0)
>         Flags: 0x00000000
>         Data length: 0
> < HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
>                           #74 [hci0] 752.276167
>         Handle: 64
> > HCI Event: Command Status (0x0f) plen 4                                =
                        #75 [hci0] 752.281522
>       LE Read Remote Used Features (0x08|0x0016) ncmd 1
>         Status: Success (0x00)
> > HCI Event: LE Meta Event (0x3e) plen 12                                =
                        #76 [hci0] 752.522510
>       LE Read Remote Used Features (0x04)
>         Status: Success (0x00)
>         Handle: 64
>         Features: 0x1f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>           LE Encryption
>           Connection Parameter Request Procedure
>           Extended Reject Indication
>           Slave-initiated Features Exchange
>           LE Ping
> < ACL Data TX: Handle 64 flags 0x00 dlen 16
>                           #77 [hci0] 752.522823
>       LE L2CAP: Connection Parameter Update Request (0x12) ident 1 len 8
>         Min interval: 40
>         Max interval: 56
>         Slave latency: 0
>         Timeout multiplier: 42
> > HCI Event: LE Meta Event (0x3e) plen 11                                =
                        #78 [hci0] 752.612551
>       LE Remote Connection Parameter Request (0x06)
>         Handle: 64
>         Min connection interval: 50.00 msec (0x0028)
>         Max connection interval: 70.00 msec (0x0038)
>         Connection latency: 0 (0x0000)
>         Supervision timeout: 420 msec (0x002a)
> < HCI Command: LE Remote Connection Parameter Request Reply
> (0x08|0x0020) plen 14                #79 [hci0] 752.612732
>         Handle: 64
>         Min connection interval: 50.00 msec (0x0028)
>         Max connection interval: 70.00 msec (0x0038)
>         Connection latency: 0 (0x0000)
>         Supervision timeout: 420 msec (0x002a)
>         Min connection length: 0.000 msec (0x0000)
>         Max connection length: 0.000 msec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 6                              =
                        #80 [hci0] 752.622017
>       LE Remote Connection Parameter Request Reply (0x08|0x0020) ncmd 1
>         Status: Success (0x00)
>         Handle: 64
> > ACL Data RX: Handle 64 flags 0x02 dlen 10                              =
                        #81 [hci0] 752.657199
>       LE L2CAP: Connection Parameter Update Response (0x13) ident 1 len 2
>         Result: Connection Parameters accepted (0x0000)
> > HCI Event: Number of Completed Packets (0x13) plen 5                   =
                        #82 [hci0] 752.755860
>         Num handles: 1
>         Handle: 64
>         Count: 1
> > HCI Event: LE Meta Event (0x3e) plen 10                                =
                        #83 [hci0] 753.017532
>       LE Connection Update Complete (0x03)
>         Status: Success (0x00)
>         Handle: 64
>         Connection interval: 60.00 msec (0x0030)
>         Connection latency: 0 (0x0000)
>         Supervision timeout: 420 msec (0x002a)
>
>
>
> Attempting to connect to another GATT Server (4F:E8:66:0A:92:63)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
>                         #403 [hci0] 1988.511852
>         Type: Passive (0x00)
>         Interval: 60.000 msec (0x0060)
>         Window: 30.000 msec (0x0030)
>         Own address type: Public (0x00)
>         Filter policy: Ignore not in white list (0x01)
> > HCI Event: Ccheck_pending_le_conn: le_num_slave =3D 1
> ommand Complete (0x0e) plen 4
>           #404 [hci0] 1988.517687
>       LE Set Scan Parameters (0x08|0x000b) ncmd 1
>         Shci_cs_le_create_conn: conn=3D972bb800
> tatus: Success (0x00)
> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>                         #405 [hci0] 1988.518123
>         Scanning: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                      #406 [hci0] 1988.523477
>       LE Set Scan Enable (0x08|0x000c) ncmd 1
>         Status: Success (0x00)
> > HCI Event: LE Meta Event (0x3e) plen 29                                =
                      #407 [hci0] 1988.551326
>       LE Advertising Report (0x02)
>         Num reports: 1
>         Event type: Connectable undirected - ADV_IND (0x00)
>         Address type: Random (0x01)
>         Address: 4F:E8:66:0A:92:63 (Resolvable)
>         Data length: 17
>         Flags: 0x02
>           LE General Discoverable Mode
>         Name (complete): LG K8 (2017)
>         RSSI: -71 dBm (0xb9)
> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>                         #408 [hci0] 1988.557402
>         Scanning: Disabled (0x00)
>         Filter duplicates: Disabled (0x00)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                      #409 [hci0] 1988.563409
>       LE Set Scan Enable (0x08|0x000c) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Create Connection (0x08|0x000d) plen 25
>                         #410 [hci0] 1988.563891
>         Scan interval: 60.000 msec (0x0060)
>         Scan window: 60.000 msec (0x0060)
>         Filter policy: White list is not used (0x00)
>         Peer address type: Random (0x01)
>         Peer address: 4F:E8:66:0A:92:63 (Resolvable)
>         Own address type: Public (0x00)
>         Min connection interval: 50.00 msec (0x0028)
>         Max connection interval: 70.00 msec (0x0038)
>         Connection latency: 0 (0x0000)
>         Supervision timeout: 420 msec (0x002a)
>         Min connection length: 0.000 msec (0x0000)
>         Max connection length: 0.000 msec (0x0000)
> > HCI Event: Command Status (0x0f) plen 4                                =
                      #411 [hci0] 1988.573442
>       LE Create Connection (0x08|0x000d) ncmd 1
>         Status: Success (0x00)
> > HCI Event: LE Meta Event (0x3e) plen 19                                =
                      #412 [hci0] 1988.839656
>       LE Connection Complete (0x01)
>         Status: Success (0x00)
>         Handle: 65
>         Role: Master (0x00)
>         Peer address type: Random (0x01)
>         Peer address: 4F:E8:66:0A:92:63 (Resolvable)
>         Connection interval: 60.00 msec (0x0030)
>         Connection latency: 0 (0x0000)
>         Supervision timeout: 420 msec (0x002a)
>         Master clock accuracy: 0x00
> @ MGMT Event: Device Connected (0x000b) plen 30
>                     {0x0001} [hci0] 1988.839788
>         LE Address: 4F:E8:66:0A:92:63 (Resolvable)
>         Flags: 0x00000000
>         Data length: 17
>         Flags: 0x02
>           LE General Discoverable Mode
>         Name (complete): LG K8 (2017)
> @ MGMT Event: Device Connected (0x000b) plen 30
>                     {0x0002} [hci0] 1988.839788
>         LE Address: 4F:E8:66:0A:92:63 (Resolvable)
>         Flags: 0x00000000
>         Data length: 17
>         Flags: 0x02
>           LE General Discoverable Mode
>         Name (complete): LG K8 (2017)
> < HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
>                         #413 [hci0] 1988.840257
>         Handle: 65
> > HCI Event: Command Status (0x0f) plen 4                                =
                      #414 [hci0] 1988.846789
>       LE Read Remote Used Features (0x08|0x0016) ncmd 1
>         Status: Success (0x00)
> > HCI Event: LE Meta Event (0x3e) plen 12                                =
                      #415 [hci0] 1989.040282
>       LE Read Remote Used Features (0x04)
>         Status: Success (0x00)
>         Handle: 65
>         Features: 0x0f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>           LE Encryption
>           Connection Parameter Request Procedure
>           Extended Reject Indication
>           Slave-initiated Features Exchange
> > HCI Event: LE Meta Event (0x3e) plen 11                                =
                      #416 [hci0] 1989.401375
>       LE Remote Connection Parameter Request (0x06)
>         Handle: 65
>         Min connection interval: 7.50 msec (0x0006)
>         Max connection interval: 7.50 msec (0x0006)
>         Connection latency: 0 (0x0000)
>         Supervision timeout: 5000 msec (0x01f4)
> < HCI Command: LE Remote Connection Parameter Request Reply
> (0x08|0x0020) plen 14              #417 [hci0] 1989.401742
>         Handle: 65
>         Min connection interval: 7.50 msec (0x0006)
>         Max connection interval: 7.50 msec (0x0006)
>         Connection latency: 0 (0x0000)
>         Supervision timeout: 5000 msec (0x01f4)
>         Min connection length: 0.000 msec (0x0000)
>         Max connection length: 0.000 msec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 6                              =
                      #418 [hci0] 1989.410534
>       LE Remote Connection Parameter Request Reply (0x08|0x0020) ncmd 1
>         Status: Success (0x00)
>         Handle: 65
> > ACL Data RX: Handle 65 flags 0x02 dlen 11                              =
                      #419 [hci0] 1989.460209
>       ATT: Read By Group Type Request (0x10) len 6
>         Handle range: 0x0001-0xffff
>         Attribute group type: Primary Service (0x2800)
> < ACL Data TX: Handle 65 flags 0x00 dlen 9
>                         #420 [hci0] 1989.461006
>       ATT: Error Response (0x01) len 4
>         Read By Group Type Request (0x10)
>         Handle: 0x0000
>         Error: Request Not Supported (0x06)
> > HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      #421 [hci0] 1989.657151
>         Num handles: 1
>         Handle: 65
>         Count: 1
> > HCI Event: LE Meta Event (0x3e) plen 10                                =
                      #422 [hci0] 1989.886359
>       LE Connection Update Complete (0x03)
>         Status: Success (0x00)
>         Handle: 65
>         Connection interval: 7.50 msec (0x0006)
>         Connection latency: 0 (0x0000)
>         Supervision timeout: 5000 msec (0x01f4)
> > HCI Event: LE Meta Event (0x3e) plen 11                                =
                      #423 [hci0] 1989.894763
>       LE Remote Connection Parameter Request (0x06)
>         Handle: 65
>         Min connection interval: 60.00 msec (0x0030)
>         Max connection interval: 60.00 msec (0x0030)
>         Connection latency: 0 (0x0000)
>         Supervision timeout: 420 msec (0x002a)
> < HCI Command: LE Remote Connection Parameter Request Reply
> (0x08|0x0020) plen 14              #424 [hci0] 1989.895117
>         Handle: 65
>         Min connection interval: 60.00 msec (0x0030)
>         Max connection interval: 60.00 msec (0x0030)
>         Connection latency: 0 (0x0000)
>         Supervision timeout: 420 msec (0x002a)
>         Min connection length: 0.000 msec (0x0000)
>         Max connection length: 0.000 msec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 6                              =
                      #425 [hci0] 1989.903898
>       LE Remote Connection Parameter Request Reply (0x08|0x0020) ncmd 1
>         Status: Success (0x00)
>         Handle: 65
> > HCI Event: LE Meta Event (0x3e) plen 10                                =
                      #426 [hci0] 1989.988169
>       LE Connection Update Complete (0x03)
>         Status: Success (0x00)
>         Handle: 65
>         Connection interval: 60.00 msec (0x0030)
>         Connection latency: 0 (0x0000)
>         Supervision timeout: 420 msec (0x002a)
>
>
> which now seems to be working,  I think maybe the first time I tried
> connecting I didn't specify that the address was a random address for
> the connection to the GATT Server running on my phone using nRF.
>
> I do have this patch in place to remove the check on le_num_slave as
> per the suggestion by Luiz
> @@ -4651,6 +4652,7 @@ static struct hci_conn
> *check_pending_le_conn(struct hci_dev *hdev,
>         struct hci_conn *conn;
>         struct hci_conn_params *params;
>
> +printk(KERN_ERR "%s: le_num_slave =3D %d\n", __func__,
> hdev->conn_hash.le_num_slave);
>         /* If the event is not connectable don't proceed further */
>         if (adv_type !=3D LE_ADV_IND && adv_type !=3D LE_ADV_DIRECT_IND)
>                 return NULL;
> @@ -4662,8 +4664,10 @@ static struct hci_conn
> *check_pending_le_conn(struct hci_dev *hdev,
>         /* Most controller will fail if we try to create new connections
>          * while we have an existing one in slave role.
>          */
> +#if 0
>         if (hdev->conn_hash.le_num_slave > 0)
>                 return NULL;
> +#endif
>
>         /* If we're not connectable only connect devices that we have in
>          * our pend_le_conns list.
>
> And during the connection I do now see the following in the journal
>
> ov 09 08:57:59 mach-cw-rnet-ppm-1717 kernel: check_pending_le_conn:
> le_num_slave =3D 1
> Nov 09 08:57:59 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c plen 2
> Nov 09 08:57:59 mach-cw-rnet-ppm-1717 kernel: skb len 5
>
> which does suggest you were right Luiz.  I'll take the patch out and
> retry the experiment to make sure.
>
> Cheers,
> Martin


I took that patch out and added a printk(KERN_ERR "FAILED CONNECTION
le_num_slave > 0); before returning NULL and it does fail the
connection and I do see the message in the journal:

Nov 09 07:56:23 mach-cw-rnet-ppm-1717 kernel: check_pending_le_conn:
le_num_slave =3D 1
Nov 09 07:56:23 mach-cw-rnet-ppm-1717 kernel: FAILED CONNECTION le_num_slav=
e > 0
