Return-Path: <SRS0=18cS=PX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C7DC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 13:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6833820866
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 13:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNAFAv/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfAONIO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:08:14 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:42072 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbfAONIN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jan 2019 08:08:13 -0500
Received: by mail-pf1-f170.google.com with SMTP id 64so1291226pfr.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jan 2019 05:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PDZSEdEyBLur6+qKO0qrsUmkXKWT3bxxdZ4F4516p38=;
        b=bNAFAv/IgExGEjx0aynL6kQBf3YBg+4GztyQCuKW7sB0SWSXAnGVi1fp4LmP6eTHHA
         bWAKk2P6U6cK9Wa3SoOe5SY6Uizrj3LuDMCWJ49IxRNMTp3bdu28hIC2ctPoxMkjN/Dl
         BI305H16YHt0vw2CcXq4p5byUm6zUnpFfmaRrWajHyYWnsgmpmnv43L51PwYdkB4HXZN
         EZOfE9dKn336eBDqj74b1VIF/+geOV+Az+0hL4p12txuORx/Kj16QJmZR+qog33/XK0X
         GW9m38w24XzV3yMHGXFkGX/6X7fDESEgJ+uHEHEu7DrEYxetoftzVy6ooeXzo3U0ZIhC
         7YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PDZSEdEyBLur6+qKO0qrsUmkXKWT3bxxdZ4F4516p38=;
        b=FH021JZlbm2m3yfWJj6MLX/EPOkHOIjmvqBpthqb5VyqPqQwtla776SKoQihZBjVXJ
         wX6LdibhAci6PqKk1BkUWxiUpF2W1TzwxNh5OJnGViizfiWnKi5Nxdt9TUXDIZb4R3lz
         b3VmVZA88+zl8kbjVVVjb4Mb9UCP+aek8/WYErH726rG0cUwQJqJXG4O4/oP0WKhLHPA
         vFWM//bGg70ZUTDNPoyFjdGXiCTaRztj3vEUuGbvLq3ZkDJZei69bPXx7Jzhb4e5dJgt
         j4IAsu6xywbDOJ9bfRsAR7U4o3S48r3odpMuMvxGdw7DgA4rG/u+RmL6Rt7aLmWUWSMW
         gY9A==
X-Gm-Message-State: AJcUukeVOJnZ1Q4SW1Q9tJEBafoH7ZXVQ9OTK8JuIzWWoFSuNmsMjvbq
        y+euDtdg6ShvpDaLp7SNUaaeLZIoGSWEn9FeSOB+mv0f
X-Google-Smtp-Source: ALg8bN4XqOydTqSZEXf5+MqC+XI8k2NL+I0Db26N2IV5xmlE14IQxWlBM6q4GK1OIo+RBNfyVzIohxjxi1yH3PSmQTs=
X-Received: by 2002:a63:4f5e:: with SMTP id p30mr3787998pgl.71.1547557691990;
 Tue, 15 Jan 2019 05:08:11 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Javier_G=C3=B3mez_Moreno?= <javgmoreno@gmail.com>
Date:   Tue, 15 Jan 2019 14:07:36 +0100
Message-ID: <CAKwnx-gTjg9kKNKpbnK9ouGhvG-zjC8YGwFGd85U7Vn5govObw@mail.gmail.com>
Subject: Porting btgatt-server and btgatt-client to ROS nodes
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi everyone, first of all let me thank anyone who's reading this. I
really appreciate it. I know time is a valuable commodity so I'll try
to summarize what I'd like to achieve in the second paragraph so if
this topic is not interesting for you, you can skip it. Also, even
though I could not find anything on the mailing list archive related
to this topic, if you think this is not the right space to discuss
this or has been discussed before somewhere else, I'll kindly ask for
pointers or suggestions for a more suitable forum. Let's get to it.

What I'm trying to achieve is to create ROS nodes
(http://www.ros.org/) for Bluetooth low energy (from now on BLE)
communication for robotics applications (like the one I'm working on).
I'd like to base it on blueZ since it is the official Linux Bluetooth
stack, so the code I would produce could be "easily" maintained,
reviewed, and used. The vision I have for this in the long term is to
have a family of Bluetooth related stable nodes based on blueZ that
could become the de-facto standard for ROS.

From this point, I'll exposed what I tried so far on this quest before
I got stuck.

So far, based on the little knowledge I managed to gather. The
sensible approach was to create a BLE GATT server ROS node, and a BLE
GATT client ROS node as a starter. So far I only got to play with the
server.

Since this is my first Bluetooth related application done on Linux,
googling around I found this
(https://stackoverflow.com/questions/29128586/bluetooth-low-energy-in-c-using-bluez-to-create-a-gatt-server)
where the steps to build and run tools/btgatt-server.c are described.
Once I got it building a running, I connected to it through the Nordic
"nRF Connect" Android app, and everything was visible including the
hearth rate monitor.

It worked like a charm, so it made sense to me as a first approach, to
try and use the btgatt-server.c source from a ros node. So first I
removed all options and defaulted them to the values I was using (no
more argument parsing) and once that was working I rewrote main as a
regular function (launch_server) and created a dummy main in
btgatt-server.c that will call "launch_server". This also worked
nicely, so next step was to remove the dummy main and call
"launch_server" from the main located in the ROS node file.

Surprisingly, that approach failed. Somehow the laptop will advertise
himself, the phone connects to it, but it wont display any services
(no more heart rate monitor for me). The application running detects
the connection but the console output stops rather soon in comparison
with the regular code being executed. If I insist re-connecting from
the phone will display the primary services "Generic Access" and
"Generic Attribute", but the console output remains "dead".

This is, for the record, the output I get with my modifications.
According to gdb the underlying "main_loop" is still running but
nothing else will ever happen.

Started listening on ATT channel. Waiting for connections
Connect from 6F:50:8F:33:8F:9D
Running GATT server
[GATT server]#

I saw that some functions are used to get the application "stuck" in
the mentioned "main_loop" to serve the client petitions from there.
Therefore,  I thought that the problem could be the ROS integration
(as ROS uses a different way of getting the application to serve
several ROS events). So to make things more simple in a first step, I
just wrote a dumb C project where I just provided a main with a "hello
world" printout and I call my "launch_server". The behavior is exactly
the same, so I could discard ROS influence for the moment.

So at this point, since I managed to build the dumb C project in a
different fashion from the ROS one, but behaves exactly as the ROS
project, I'm starting to think that the way I build the code might be
the key. For the dumb C project I just used a standard eclipse CDT
project, so my first guess is that some things might be happening in
blueZ makefile that makes the difference between the correct behavior
and the bad one. I've been playing around with the makefiles myself
for a couple of days but to be honest, I'm not really experienced with
them. So I find myself in a position where I can't dig any further
without help or a sudden flash of inspiration.

If you made it to this point, thank you for you patience! The dumb
project code with the modifications just for completion is located in
https://gitlab.com/jagomo/dummy-bluez-test (note that btgatt-server.c
has been renamed to btgatt-server-ros.c)

Keep in mind that the blueZ source in there is not complete as eclipse
was trying to build completely blueZ, even files that apparently
weren't required to build btgatt-server.c. So I removed some files
here and there to make my life easier and with less compilation
errors. The ROS project used the full code base, as ROS build tools
were smart enough to figure out what made sense to include.

Up to this point, several questions arises:
- What could I be missing that "makes the magic happen"? Any pointers
and hints to keep digging would be greatly appreciated.

- Is this approach sensible at all? Is there an easier (in sense of
more maintainable in the long run) way to implement the GATT server
and client in a custom application using blueZ? If so, which method
would you recommend? which libraries would you recommend to master for
such method? Do you know any good resources to do so?

- Is there more blueZ documentation/resources beyond the source code
and doc folder? Specifically, any good resources regarding BLE for
programmers using blueZ. Resources that explain in a noob friendly the
big picture about blueZ in a more general way are also welcome.

Once again, thanks in advance for the help. I'll be grateful for any
answer (big, small or partial) shared.

Kind regards,

Javier Gomez Moreno.
