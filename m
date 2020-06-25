Return-Path: <SRS0=OFBO=AG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535A5C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 21:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137AF20768
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 21:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vImEFICc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405716AbgFYVMb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405670AbgFYVMa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jun 2020 17:12:30 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8233DC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2020 14:12:30 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s10so6008253oih.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2020 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9sDOwoeCZT+MxijlOzitUPOv2MjsWunsLgKimDc1Xtk=;
        b=vImEFICcH1wV0UpqsAe68Ge1AS5+uXLVfCb5t3fW+0RGPh3i5o1WuGTOn9yABdKCPl
         6v0nfZX7qN2gEsW73MnbnnJv6Wk6z+NOCqzfupQJ6Kc4pkPn/C6WoJJOjDrinhLhxP8U
         1Z8KX+fiU7g7Our3CzumBoRh3zzR674V81hYGqg98dzeVPwsfGx0tgLR/1+uxozR+zxP
         IP2FNsw0Wk6jGyjPzTW0qE//0tdbku2ZCInQ/NGxBJ/baiGfl+ZN4Sl4FBkSFVKTITHe
         FP0v2nxH5ltWi+zTxRX08Y+BZk+LAPAMCJofIfLJzp6Q+Bt+OCs7+Fdz8KivyLLotQOO
         IWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9sDOwoeCZT+MxijlOzitUPOv2MjsWunsLgKimDc1Xtk=;
        b=a6bQaADHqvYEjbgv+1LWRjSAUd23boIAjMCNGFx12TAbcDGPOAfrxdlCQJx1rz4c0I
         e2hV+WE+i0pwWhlgN2xY6q4rh6Aj/VCJXbIlqFXI8bqMrjnQx1CpsSYhwJwVwcpLJ1gy
         JIKaa7anogF09MXQqlPcRnsl44hYpejGt9AHyucP0p4CWn0Parl86D9QyMrY7bxUQEks
         QnE4OW2eB1wCakCSan1lf6nuROFtZVp9IRivLkLKdlm6nb+Ekinvt6P4LvHbF40/kYBt
         +JV4d9eZdP04NefCJdR+QCQAsYCskJqcljV2qhDCLEOqYgUHslFWwuSMrOxTwhDobwYh
         AN4Q==
X-Gm-Message-State: AOAM532GHXTyj2jtf3Gm5244Q/lAy/uD5DzpS6PEmWyPVXy62OWhprIt
        yDmyx+HCxld0jIRJBs3cBdL7pA+FCdRZXRtOef3NGVPi3/k=
X-Google-Smtp-Source: ABdhPJyWRdNzM8tgvaZLRid331PNNmiG5khFLHNcYws4JvIG3lS8xUiiQzK2yv8XjL2CcpObx+SASZfUhAM1piAUh1E=
X-Received: by 2002:aca:49cb:: with SMTP id w194mr3781377oia.152.1593119549524;
 Thu, 25 Jun 2020 14:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <yZpTVIoy_4_lKVatpEXUFe3q3tXmvfdSwUiSGO1UiLaRoODws9PoqLXuyxok4Sl_ZS6mvH-sEdurYCkmbNTtRc38-J5yqAtfH6BIXU7INTM=@ecentrum.hu>
In-Reply-To: <yZpTVIoy_4_lKVatpEXUFe3q3tXmvfdSwUiSGO1UiLaRoODws9PoqLXuyxok4Sl_ZS6mvH-sEdurYCkmbNTtRc38-J5yqAtfH6BIXU7INTM=@ecentrum.hu>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 25 Jun 2020 14:12:18 -0700
Message-ID: <CABBYNZLry-8-R1dfnm_usYS-B7EBcL4Dgctw2Cnb8MiEd43v9g@mail.gmail.com>
Subject: Re: bluetoothd repeatedly crashes with Logitech MX Keys keyboard
To:     =?UTF-8?B?TMOpdmFpLCBEw6FuaWVs?= <leva@ecentrum.hu>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi D=C3=A1niel,

On Wed, Jun 24, 2020 at 3:05 PM L=C3=A9vai, D=C3=A1niel <leva@ecentrum.hu> =
wrote:
>
> Hi list!
>
> First post here, be gentle :)
>
> So I'm having these bluetoothd crashes when I turn on my Logitech MX Keys=
 keyboard. It lasts for a while, meaning it crashes, then systemd starts it=
 up again, then crashes again, etc... For about 1-2 minutes, then it "settl=
es" (I don't know how else to put it, but as long as I keep pressing button=
s and the keyboard reconnects, the crashes stop after a while, usually afte=
r about 1-2 minutes).
> I'm using aarch64 (ARMv8) on a raspberry pi 4 and Manjaro Linux (Arch-bas=
ed) with bluez-5.54:
> 5.7.3-1-MANJARO-ARM #1 SMP PREEMPT Wed Jun 17 13:20:14 CDT 2020 aarch64 G=
NU/Linux
>
> Here's the backtrace:
> Core was generated by `/usr/lib/bluetooth/bluetoothd'.
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  queue_remove (queue=3D0x559c1b6d40, data=3Ddata@entry=3D0x559c1c7d00)=
 at src/shared/queue.c:259
> 259                             continue;
> (gdb) list
> 254                     return false;
> 255
> 256             for (entry =3D queue->head, prev =3D NULL; entry;
> 257                                             prev =3D entry, entry =3D=
 entry->next) {
> 258                     if (entry->data !=3D data)
> 259                             continue;
> 260
> 261                     if (prev)
> 262                             prev->next =3D entry->next;
> 263                     else
> (gdb) bt
> #0  queue_remove (queue=3D0x559c1b6d40, data=3Ddata@entry=3D0x559c1c7d00)=
 at src/shared/queue.c:259
> #1  0x000000558fc4f928 in enable_ccc_callback (opcode=3D<optimized out>, =
pdu=3D<optimized out>, length=3D<optimized out>, user_data=3D0x559c1c7d00) =
at src/shared/gatt-client.c:1627
> #2  0x000000558fc4947c in disc_att_send_op (data=3D0x559c1a6c30) at src/s=
hared/att.c:417
> #3  0x000000558fc43c18 in queue_remove_all (queue=3D<optimized out>, func=
tion=3Dfunction@entry=3D0x0, user_data=3Duser_data@entry=3D0x0, destroy=3Dd=
estroy@entry=3D0x558fc49450 <disc_att_send_op>) at src/shared/queue.c:353
> #4  0x000000558fc4b7b8 in disconnect_cb (io=3D<optimized out>, user_data=
=3D0x559c1bbe00) at src/shared/att.c:635
> #5  0x000000558fc586e8 in watch_callback (channel=3D<optimized out>, cond=
=3D<optimized out>, user_data=3D<optimized out>) at src/shared/io-glib.c:17=
0
> #6  0x0000007fb94ed66c in g_main_context_dispatch () from /usr/lib/libgli=
b-2.0.so.0
> #7  0x0000007fb94edaf8 in ?? () from /usr/lib/libglib-2.0.so.0
> #8  0x0000007fb94edf00 in g_main_loop_run () from /usr/lib/libglib-2.0.so=
.0
> #9  0x000000558fc58e78 in mainloop_run () at src/shared/mainloop-glib.c:7=
9
> #10 0x000000558fc59394 in mainloop_run_with_signal (func=3D<optimized out=
>, user_data=3D0x0) at src/shared/mainloop-notify.c:201
> #11 0x000000558fba2c3c in main (argc=3D<optimized out>, argv=3D<optimized=
 out>) at src/main.c:770
> (gdb) bt full
> #0  queue_remove (queue=3D0x559c1b6d40, data=3Ddata@entry=3D0x559c1c7d00)=
 at src/shared/queue.c:259
>         entry =3D <error reading variable entry (Cannot access memory at =
address 0x59)>
>         prev =3D 0x51
> #1  0x000000558fc4f928 in enable_ccc_callback (opcode=3D<optimized out>, =
pdu=3D<optimized out>, length=3D<optimized out>, user_data=3D0x559c1c7d00) =
at src/shared/gatt-client.c:1627
>         notify_data =3D 0x559c1c7d00
>         att_ecode =3D <optimized out>
>         __PRETTY_FUNCTION__ =3D "enable_ccc_callback"
> #2  0x000000558fc4947c in disc_att_send_op (data=3D0x559c1a6c30) at src/s=
hared/att.c:417
>         op =3D 0x559c1a6c30
> #3  0x000000558fc43c18 in queue_remove_all (queue=3D<optimized out>, func=
tion=3Dfunction@entry=3D0x0, user_data=3Duser_data@entry=3D0x0, destroy=3Dd=
estroy@entry=3D0x558fc49450 <disc_att_send_op>) at src/shared/queue.c:353
>         tmp =3D 0x559c1b14a0
>         entry =3D 0x0
>         count =3D 9
> #4  0x000000558fc4b7b8 in disconnect_cb (io=3D<optimized out>, user_data=
=3D0x559c1bbe00) at src/shared/att.c:635
>         chan =3D 0x559c1bbe00
>         att =3D 0x559c1c8890
>         err =3D 110
>         len =3D 4
> #5  0x000000558fc586e8 in watch_callback (channel=3D<optimized out>, cond=
=3D<optimized out>, user_data=3D<optimized out>) at src/shared/io-glib.c:17=
0
>         watch =3D <optimized out>
>         result =3D <optimized out>
>         destroy =3D <optimized out>
> #6  0x0000007fb94ed66c in g_main_context_dispatch () from /usr/lib/libgli=
b-2.0.so.0
> No symbol table info available.
> #7  0x0000007fb94edaf8 in ?? () from /usr/lib/libglib-2.0.so.0
> No symbol table info available.
> #8  0x0000007fb94edf00 in g_main_loop_run () from /usr/lib/libglib-2.0.so=
.0
> No symbol table info available.
> #9  0x000000558fc58e78 in mainloop_run () at src/shared/mainloop-glib.c:7=
9
> No locals.
> #10 0x000000558fc59394 in mainloop_run_with_signal (func=3D<optimized out=
>, user_data=3D0x0) at src/shared/mainloop-notify.c:201
>         data =3D 0x559c199170
>         io =3D 0x559c19a330
>         ret =3D <optimized out>
> #11 0x000000558fba2c3c in main (argc=3D<optimized out>, argv=3D<optimized=
 out>) at src/main.c:770
>         context =3D <optimized out>
>         err =3D 0x0
>         sdp_flags =3D <optimized out>
>         gdbus_flags =3D <optimized out>
>         __func__ =3D "main"
>
>
> And here's the log from bluetoothd while this happens:
> Jun 24 22:39:01 hostname bluetoothd[434271]: Read Report Reference descri=
ptor failed: Request attribute has encountered an unlikely error
> Jun 24 22:39:01 hostname bluetoothd[434271]: Read Report Reference descri=
ptor failed: Request attribute has encountered an unlikely error
> Jun 24 22:39:01 hostname bluetoothd[434271]: Read Report Reference descri=
ptor failed: Request attribute has encountered an unlikely error
> Jun 24 22:39:01 hostname bluetoothd[434271]: Read Report Reference descri=
ptor failed: Request attribute has encountered an unlikely error
> Jun 24 22:39:01 hostname bluetoothd[434271]: Read Report Reference descri=
ptor failed: Request attribute has encountered an unlikely error
> Jun 24 22:39:01 hostname bluetoothd[434271]: Read Report Reference descri=
ptor failed: Request attribute has encountered an unlikely error
> Jun 24 22:39:01 hostname bluetoothd[434271]: Protocol Mode characteristic=
 read failed: Request attribute has encountered an unlikely error
> Jun 24 22:39:02 hostname systemd[1]: bluetooth.service: Main process exit=
ed, code=3Ddumped, status=3D11/SEGV
> Jun 24 22:39:02 hostname systemd[1]: bluetooth.service: Failed with resul=
t 'core-dump'.
> Jun 24 22:39:02 hostname systemd[1]: bluetooth.service: Scheduled restart=
 job, restart counter is at 1.
> Jun 24 22:39:02 hostname systemd[1]: Stopped Bluetooth service.
> Jun 24 22:39:02 hostname systemd[1]: Starting Bluetooth service...
> Jun 24 22:39:02 hostname bluetoothd[436294]: Bluetooth daemon 5.54
> Jun 24 22:39:02 hostname systemd[1]: Started Bluetooth service.
> Jun 24 22:39:02 hostname bluetoothd[436294]: Starting SDP server
> Jun 24 22:39:02 hostname bluetoothd[436294]: Bluetooth management interfa=
ce 1.16 initialized
> Jun 24 22:39:02 hostname bluetoothd[436294]: Failed to set privacy: Rejec=
ted (0x0b)
> Jun 24 22:39:02 hostname bluetoothd[436294]: Endpoint registered: sender=
=3D:1.53 path=3D/MediaEndpoint/A2DPSink/sbc
> Jun 24 22:39:02 hostname bluetoothd[436294]: Endpoint registered: sender=
=3D:1.53 path=3D/MediaEndpoint/A2DPSource/sbc
> Jun 24 22:39:08 hostname bluetoothd[436294]: No cache for E6:25:BB:xx:xx:=
xx
> Jun 24 22:39:08 hostname bluetoothd[436294]: BATT attribute not found
> Jun 24 22:39:08 hostname bluetoothd[436294]: batt-profile profile accept =
failed for E6:25:BB:xx:xx:xx
> Jun 24 22:39:08 hostname bluetoothd[436294]: GAP attribute not found
> Jun 24 22:39:08 hostname bluetoothd[436294]: gap-profile profile accept f=
ailed for E6:25:BB:xx:xx:xx
> Jun 24 22:39:08 hostname bluetoothd[436294]: input-hog profile accept fai=
led for E6:25:BB:xx:xx:xx
> Jun 24 22:39:11 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:11 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:11 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:11 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:11 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:11 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:21 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:21 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:21 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:21 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:21 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:21 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:21 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:21 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:21 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:21 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:33 hostname bluetoothd[436294]: Report Map parsing failed at=
 87
> Jun 24 22:39:33 hostname bluetoothd[436294]: Failed to connection details=
: getpeername: Transport endpoint is not connected (107)
> Jun 24 22:39:40 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:40 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:40 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:40 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:40 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:40 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:40 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:40 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:41 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:41 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:41 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:41 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:41 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:41 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:41 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:41 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:41 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:39:47 hostname bluetoothd[436294]: Write output report failed: =
Request attribute has encountered an unlikely error
> Jun 24 22:40:01 hostname bluetoothd[436294]: Write report characteristic =
descriptor failed: Request attribute has encountered an unlikely error
> Jun 24 22:40:01 hostname bluetoothd[436294]: Write report characteristic =
descriptor failed: Request attribute has encountered an unlikely error
> Jun 24 22:40:01 hostname bluetoothd[436294]: Write report characteristic =
descriptor failed: Request attribute has encountered an unlikely error
> Jun 24 22:40:01 hostname bluetoothd[436294]: Report Map parsing failed at=
 65
> Jun 24 22:40:01 hostname bluetoothd[436294]: Failed to connection details=
: getpeername: Transport endpoint is not connected (107)
> Jun 24 22:40:01 hostname bluetoothd[436294]: Write report characteristic =
descriptor failed: Request attribute has encountered an unlikely error
> Jun 24 22:40:04 hostname bluetoothd[436294]: No cache for E6:25:BB:xx:xx:=
xx
> Jun 24 22:40:08 hostname bluetoothd[436294]: Unable to register org.bluez=
.Battery1 interface for /org/bluez/hci0/dev_E6_25_BB_xx_xx_xx
> Jun 24 22:40:09 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:09 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:09 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:09 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:40:43 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:14 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:15 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:15 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:15 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:49 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:49 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:49 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:49 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:49 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:49 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:49 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:50 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:50 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:50 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:50 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:50 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:57 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:57 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:57 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:57 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:58 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:58 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:58 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:58 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:58 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:58 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:58 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:58 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:58 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:58 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:58 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:41:58 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:23 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:23 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:23 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:24 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:24 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:24 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:24 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:24 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: Write output report failed: =
Request attribute has encountered an unlikely error
> Jun 24 22:42:30 hostname bluetoothd[436294]: Write output report failed: =
Request attribute has encountered an unlikely error
> Jun 24 22:42:30 hostname bluetoothd[436294]: Write output report failed: =
Request attribute has encountered an unlikely error
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:30 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:44 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:44 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:44 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:44 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:44 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:54 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:54 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:54 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:54 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:54 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:54 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:54 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:42:55 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:06 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:06 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:06 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:06 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:06 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:06 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:06 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:06 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:16 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:16 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:16 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:16 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
> Jun 24 22:43:16 hostname bluetoothd[436294]: bt_uhid_send: Invalid argume=
nt (22)
>
> I guess this latter would be more useful with --debug=3D<something>, but =
I'm not sure what would be a good option there. If it helps, I'd be happy t=
o retest this with the debug parameter to bluetoothd.
>
> Is this (MX Keys or BLE) something that's been known to confuse bluez?

Thanks for the report, Ive sent a tentative fix for the problem above:

https://lore.kernel.org/linux-bluetooth/20200625211125.2239435-1-luiz.dentz=
@gmail.com/T/#u

--=20
Luiz Augusto von Dentz
