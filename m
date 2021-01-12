Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8CEC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jan 2021 23:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB1223131
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jan 2021 23:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbhALXdW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Jan 2021 18:33:22 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49213 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730434AbhALXdW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Jan 2021 18:33:22 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id AB1045C00A6;
        Tue, 12 Jan 2021 18:32:35 -0500 (EST)
Received: from imap6 ([10.202.2.56])
  by compute2.internal (MEProxy); Tue, 12 Jan 2021 18:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=+ZUyVd7ECo25pI58gjgnFplXr9SywPM
        0BOvzakAFoGw=; b=uhDzWon1LjDj9qYidCABnHaC80+M/A/IKNKRC0ulJnUkLvn
        Zstc00NXLxwJ15d4/3zrxLLQ+V4TOlswtMRtWab+uHk3zJrYeBJdfMAasbJig0Eq
        fiMvbatXRcybQQFdoQjg4GCqoZ8q6q17tY4qQIx2HhdVTPHYUTjMVgxG4oTGyU5T
        Km1kQA3uaNfWckOMmnh6fSXk9lJxP7WUC89ONiBUxpbcY7fq7jQjCd4whShgLV3b
        TMIT5YyCX2rBLcYbpUzVbh2idilMSN60Oxn84ojqCPaBrDjdvnDLe42yui0NmakY
        SzYWf/nrsPIRvpRq0VkUwSmcL4QShuCPPoW8GEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+ZUyVd
        7ECo25pI58gjgnFplXr9SywPM0BOvzakAFoGw=; b=UH2OGF/JIUWn9gSZZogpgg
        0dmmwxVOXWXSJsfpEjs7XS0Ojl2sODEEEDPJrjSefZY69nET4NjRl/LuVlM67aZb
        8MmO6MKNNWBfkWFghwuzelSfZRKeRmXL//TbpPCriRGsTI+PdNUitJqb7ZPU1U6A
        WsLHerKao5nDT3CryUlMHvgYJzoumW2nRQlZO9JSJ9ea7TgGYfQfJNM8rxApu5mP
        YD1id+ogrhRHFFXXpv0gPt6BcD4vhsXnlPx+l6OO1yc8FdkrN30anU/MVaNcjQhu
        v2p/ICjzuXXlwsmw94DeY3VBPmeuiEFbUFbwLlRrpXJnwVNxZN2BX3bqFPtPRnEQ
        ==
X-ME-Sender: <xms:kzH-X3sjJvuppXvG5dSzkXVe4Bj7702Quwf3k5OHISRTKBWWSiArDQ>
    <xme:kzH-X4e5d9rK9zzC8EIjEQppvdQ30BOocgTsysuy1JSgDb4VR-xk7e7JuroShLoVo
    qnbPBWxJA2Io2xBVRc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfvehhrhhi
    shhtohhphhgvrhcuhghilhhlihgrmhcuufhnohifhhhilhhlfdcuoegthhhrihhssehkoh
    guvgehgedrnhgvtheqnecuggftrfgrthhtvghrnhepfefhuddvleffhedtkeeiudetteel
    ieeitdehheeutdevhfettdegjeeiudfhueehnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhrhhisheskhhouggvheegrdhnvght
X-ME-Proxy: <xmx:kzH-X6ygfaeihpUlisWWPaIdWNLkueotFP-dPLENkJUigYWXMd43yQ>
    <xmx:kzH-X2NdS7r5P3gGxCq1LpIjIN32gmsxc4A2G_6lMFokHXZbpIKUyQ>
    <xmx:kzH-X395hTXvkphfYbIsl3yOtsxSEdFTCcrJnakbOZ_xVxCvig1HbA>
    <xmx:kzH-X0GnJdMgSl8UuLBBhemayAeK6cOqUtc-SNtGO4Zc-9N7_laHoA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 61B541400A1; Tue, 12 Jan 2021 18:32:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-45-g4839256-fm-20210104.001-g48392560
Mime-Version: 1.0
Message-Id: <b5721f11-20d4-4d19-83a3-b9d7b5bc2378@www.fastmail.com>
In-Reply-To: <CABatt_zyrDQX1YzVjSCDDhmRhhf+DfubX+pa_cwD7_fJs2zrgA@mail.gmail.com>
References: <CABatt_w0CxJGX7Vp+h-hOe3EE0CgjWiprom400iawXJ4BmbURQ@mail.gmail.com>
 <B1F1FD56-9B66-4AF2-90B3-6A2D9DBBA861@holtmann.org>
 <CABatt_zyrDQX1YzVjSCDDhmRhhf+DfubX+pa_cwD7_fJs2zrgA@mail.gmail.com>
Date:   Tue, 12 Jan 2021 15:32:14 -0800
From:   "Christopher William Snowhill" <chris@kode54.net>
To:     "Martin Townsend" <mtownsend1973@gmail.com>,
        "Marcel Holtmann" <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?Q?Re:_bluetoothctl_not_listing_the_controller_when_I_disable_the?=
 =?UTF-8?Q?_HID_profiles?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Jan 12, 2021, at 5:03 AM, Martin Townsend wrote:
> Hi Marcel
> 
> On Sat, Jan 9, 2021 at 9:17 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Martin,
> >
> > > I've been debugging a problem where my bluetooth device wasn't showing
> > > up in bluetoothctl.  I was building with the following configuration:
> > >
> > > --disable-a2dp --disable-avrcp --disable-btpclient --disable-cups
> > > --enable-deprecated --enable-health --disable-hid --disable-hog
> > > --disable-mesh --disable-midi --disable-network --disable-nfc
> > > --disable-obex --enable-client --disable-sap --disable-sixaxis
> > > --enable-systemd --disable-testing --disable-threads --enable-tools
> > > --disable-udev
> > >
> > > Basically the stack is running on a very resource constrained MIPS
> > > based board so I'm trying to reduce the stack down to the essential
> > > which is just to read BLE sensors.  But with this configuration
> > > bluetoothctl lists no default controllers.  Now if I enable HID
> > > profiles with
> > > --enable-hid
> > >
> > > It works and I can list the controller and connect to a BLE sensor and
> > > perform all the various GATT commands.
> > >
> > > Is this expected? I would have thought I could safely disable HID
> > > profiles as I'm not going to be connecting any keyboards or mice.
> > >
> > > Bluez stack is 5.54
> > > Kernel is 5.4.76
> > >
> > > This was built using Yocto but I'm sure I could get this build a newer
> > > version if you think this has already been fixed.
> > >
> > > One thing I've noticed is that when bringing up hci0 when HID is
> > > enabled I get the following
> > >
> > > hciconfig hci0 up
> > > [   48.704477][  T140] rtk_btusb: btusb_open start
> > > [   48.713535][  T140] rtk_btusb: btusb_open hdev->promisc ==0
> > > [   48.724586][  T140] rtk_btusb: download_patch start
> > > [   48.734262][  T140] rtk_btusb: chip type value: 0x74
> > > [   48.744098][  T140] rtk_btusb: HCI reset.
> > > [   48.763108][  T140] rtk_btusb: read_ver_rsp->lmp_subver = 0x646b
> > > [   48.775279][  T140] rtk_btusb: read_ver_rsp->hci_rev = 0x999
> > > [   48.786501][  T140] rtk_btusb: patch_entry->lmp_sub = 0x8761
> > > [   48.797712][  T140] rtk_btusb: Firmware already exists
> > > [   48.807889][  T140] rtk_btusb: Rtk patch end 1
> > > [   48.816687][  T140] rtk_btusb: btusb_open set HCI_RUNNING
> > > [   48.827449][  T140] rtk_btcoex: Open BTCOEX
> > > [   48.835745][  T140] rtk_btusb: btusb_open end
> > > [   48.849158][    T3] rtk_btcoex: BTCOEX hci_rev 0x0999
> > > [   48.859302][    T3] rtk_btcoex: BTCOEX lmp_subver 0x646b
> > > Can't init device hci0: Invalid argument (22)
> > >
> > > even though there is an error it works!!!
> > >
> > > When it's disabled I don't get the error at the end and it doesn't work:
> > >
> > > [   44.084337][  T137] rtk_btusb: btusb_open start
> > > [   44.093395][  T137] rtk_btusb: btusb_open hdev->promisc ==0
> > > [   44.104446][  T137] rtk_btusb: download_patch start
> > > [   44.114109][  T137] rtk_btusb: chip type value: 0x74
> > > [   44.123946][  T137] rtk_btusb: HCI reset.
> > > [   44.143090][  T137] rtk_btusb: read_ver_rsp->lmp_subver = 0x8761
> > > [   44.155259][  T137] rtk_btusb: read_ver_rsp->hci_rev = 0xb
> > > [   44.166140][  T137] rtk_btusb: patch_entry->lmp_sub = 0x8761
> > > [   44.177350][  T137] rtk_btusb: load_firmware start
> > > [   44.186843][  T137] rtk_btusb: lmp_version = 0x8761
> > > [   44.196502][  T137] rtk_btusb: config filename rtl8761bu_config
> > > [   44.214206][  T137] LoadPin: mnt_sb lacks block device, treating as: writable
> > > [   44.228442][  T137] LoadPin: enforcement can be disabled.
> > > [   44.240206][  T137] LoadPin: firmware pinned
> > > obj="/lib/firmware/rtl8761bu_config" pid=137 cmdline="hciconfig hci0
> > > up"
> > > [   44.263326][  T137] rtk_btusb: no bdaddr file /opt/bdaddr
> > > [   44.274090][  T137] rtk_btusb: Origin cfg len 6
> > > [   44.283073][  T137] rtk_btusb: 55 ab 23 87 00 00
> > > [   44.292235][  T137] rtk_btusb: New cfg len 6
> > > [   44.300690][  T137] rtk_btusb: 55 ab 23 87 00 00
> > > [   44.312206][  T137] rtk_btusb: fw name is  rtl8761bu_fw
> > > [   44.328515][  T137] rtk_btusb: This is not 8723a, use new patch style!
> > > [   44.341527][  T137] rtk_btusb: rtk_get_eversion: gEVersion 255
> > > [   44.355112][  T137] rtk_btusb: eversion->status = 0x0,
> > > eversion->version = 0x1
> > > [   44.369710][  T137] rtk_btusb: load_firmware: New gEVersion 1
> > > [   44.381110][  T137] rtk_btusb: rtk_get_fw_project_id: opcode 0, len
> > > 1, data 14
> > > [   44.395424][  T137] rtk_btusb: lmp_version is 8761, project_id is
> > > 8761, match!
> > > [   44.409728][  T137] rtk_btusb: fw_version = 0x999646b
> > > [   44.419731][  T137] rtk_btusb: number_of_total_patch = 2
> > > [   44.430250][  T137] rtk_btusb: chipID 2
> > > [   44.437847][  T137] rtk_btusb: patch_length 0x5024
> > > [   44.447331][  T137] rtk_btusb: start_offset 0x00003780
> > > [   44.457508][  T137] rtk_btusb: Svn version:    23166
> > > [   44.467339][  T137] rtk_btusb: Coexistence: BTCOEX_20190327-0202
> > > [   44.479235][  T137] rtk_btusb: buf_len = 0x502a
> > > [   44.488460][  T137] rtk_btusb: fw: exists, config file: exists
> > > [   44.500037][  T137] rtk_btusb: load_firmware done
> > > [   44.515792][  T137] rtk_btusb: download_data start
> > > [   44.636082][  T137] rtk_btusb: download_data done
> > > [   44.645683][  T137] rtk_btusb: HCI reset.
> > > [   44.665084][  T137] rtk_btusb: read_ver_rsp->lmp_subver = 0x646b
> > > [   44.677260][  T137] rtk_btusb: read_ver_rsp->hci_rev = 0x999
> > > [   44.688487][  T137] rtk_btusb: patch_entry->lmp_sub = 0x8761
> > > [   44.699720][  T137] rtk_btusb: Rtk patch end 0
> > > [   44.708525][  T137] rtk_btusb: btusb_open set HCI_RUNNING
> > > [   44.719288][  T137] rtk_btcoex: Open BTCOEX
> > > [   44.727576][  T137] rtk_btusb: btusb_open end
> > > [   44.741138][   T43] rtk_btcoex: BTCOEX hci_rev 0x0999
> > > [   44.751278][   T43] rtk_btcoex: BTCOEX lmp_subver 0x646b
> > > [   44.782126][   T56] rtk_btusb: btusb_notify: hci0 evt 3
> >
> > this is an out-of-tree driver. Take it up with Realtek.
> >
> > Regards
> >
> > Marcel
> >
> 
> If it's a driver problem then I'll look for another device and we are
> not committed to this one.  If anyone can recommend a USB dongle that
> is well supported by a 5.4 kernel that would greatly appreciated :)
> It doesn't have to be bluetooth 5.0 but we would like the security
> features of BLE 4.2

Perhaps the dongle that I just ordered? It's a Laird BT851, and there are
several places to order them from. Digi-Key has about 1500 of them in
stock right now, for $10.99 USD each for the minimum quantity of one.

Bluetooth 5.0, firmware built-in, natively supported by btusb, as well
as Windows, and macOS Catalina, if that matters to anyone for alternate
uses.

When mine arrives on the 15th or so, I can let anyone know of how it
functions, whether well or poorly.


> Cheers,
> Martin.
> 
