Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E943AC4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 19:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07D023A33
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 19:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbgLITHm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:07:42 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:57883 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgLITHa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 14:07:30 -0500
Received: from [192.168.100.1] ([82.252.152.214]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MPooN-1kROsh09LP-00MsIe; Wed, 09 Dec 2020 20:04:52 +0100
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: Bluetooth printer connection error
To:     Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
References: <3a6fa942-bec5-5e5f-391d-197d1c1eafa6@vivier.eu>
 <e885258a0b9a3ba15640553e9f002cdfc89f4b79.camel@hadess.net>
 <73236e71-781f-1dea-13d5-61fdc45d5e13@vivier.eu>
 <0eeb1a4a1254d00b2d1a8f77133af4d16857b266.camel@hadess.net>
Message-ID: <ab6ae9d9-9104-5454-d93d-b734c0eb9eba@vivier.eu>
Date:   Wed, 9 Dec 2020 20:04:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <0eeb1a4a1254d00b2d1a8f77133af4d16857b266.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+DGd3fZ42T5xu7qkH5FBo7WGmTDxSyXjxMrVINoWBeqAxsn7G1D
 X9JW91Mrz6wMVlmuMiDeK6LF6b5K3vQq8mVl64evHpkyuwAyB7pjjFI/pem5v1yhlyKeJEN
 Ec/jz1sVCLCdS81NpV8XnKBoT3DHjouOeG7illm0rwL5042RnEBjUl5lqlimlsKTKMBQMZf
 o0lNaTYgE4awG8iIsykTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1gnEd/0GrBI=:t/1yPnlpYUnatrM53mweXW
 ZKQIR2bFsNbbpeLYoj+fPj6asYoo4N3E+4Xly+A+W9PI247kdtd0l88jPW2ujOz7G9+W+rN0G
 0EzY8fWEXgWiwdFNGPQnSxQubCjuGQziPK6OSyQj/xiDfJ5rqZPKy6yXmugTC5fo3yB1bG+I7
 m5AWQKAwyvgOn8uDoR5y1EUlIP497bz42DT0Y9TjrQLbikIl8z7vOwgg+vXdKUNoigTeOSSds
 Xacgu7a27kn9nLxaGUhkDQ7wGJYPdoPvPjoVESO+BPYUW1bBF/fKKRkWJyNb964W2szVa39H5
 NCUgr3VPgyLMx4ONhHKxiACn2UunSUjJHVIt2MkZsinG3WholXM1IvVh1h3pW41ypIM4sJ23D
 zGdWDYGD6xNU6kq5XgnRN4BQn+FbxUg9lfqMirUTDUy+DdZoKxYfu4eTnBj0uvWon024P5Eat
 0HjYHmoa4g==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Le 09/12/2020 à 12:34, Bastien Nocera a écrit :
> On Wed, 2020-12-09 at 12:14 +0100, Laurent Vivier wrote:
...
>>> If the printer has uses the SPP or HCRP printing profiles, you
>>> should
>>> see it when using:
>>> /usr/lib/cups/backend/bluetooth
>>> without any arguments.
>>
>> As I don't see it once it is paired, I guess it is not using one of
>> these profiles.
> 
> I don't remember how this used to work, but you'll probably only see
> something if the printer is visible.
> 
> You might be able to get the printer to work by adding:
> bluetooth://DC0D309023C7
> as a printer in the printer settings of your favourite desktop
> environment, if it actually uses SPP.
> 
> running the cups backend with:
> /usr/lib/cups/backend/bluetooth --get-deviceid bluetooth://DC0D309023C7
> 
> should show you whether it can get autoconfigured for CUPS use.
> 

Thank you Bastien, it's exactly what I needed to know.

Correct me if I'm wrong but it seems there is a bug in the cups/bluetooth
command:

profiles/cups/main.c

602 static gboolean print_ieee1284(const char *bdaddr)
...
616         message = dbus_message_new_method_call("org.bluez", "/",
617                         "org.bluez.Manager",
618                         "DefaultAdapter");
619
620         adapter_reply = dbus_connection_send_with_reply_and_block(conn,
621                         message, -1, NULL);

adapter_reply is always NULL.

I can see following errors with dbus-monitor:

method call time=1607536119.751900 sender=:1.194 -> destination=org.bluez serial=2 path=/;
interface=org.bluez.Manager; member=DefaultAdapter
error time=1607536119.752107 sender=:1.71 -> destination=:1.194
error_name=org.freedesktop.DBus.Error.UnknownMethod reply_serial=2
   string "Method "DefaultAdapter" with signature "" on interface "org.bluez.Manager" doesn't exist
"

And I can find a commit removing calls to org.bluez.Manager:

commit 86a7b07c22f3a595ba3c48092359287905bf0878
Author: Mikel Astiz <mikel.astiz@bmw-carit.de>
Date:   Wed Dec 5 13:51:34 2012 +0100

    dbus: Remove org.bluez.Manager

    After the decision to drop the "default-adapter" feature in the D-Bus
    API, the org.bluez.Manager interface can be entirely dropped since it
    has been replaced by the ObjectManager.


What did I miss?

Thanks,
Laurent
