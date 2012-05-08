Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPsQmjqVJ93mpSv-0S6s2KavKonh6+=1R4QgUDRfjRtv7QwWnA@mail.gmail.com>
References: <CAPsQmjrMuUbiqymU48V2m4Lz7_33gudS8FMHijoNq_9UquPosw@mail.gmail.com>
 <CABBYNZK8W_4beoA+qg1e4E7QpsoswAzCULVbO9djgBkk8L1Wdg@mail.gmail.com> <CAPsQmjqVJ93mpSv-0S6s2KavKonh6+=1R4QgUDRfjRtv7QwWnA@mail.gmail.com>
From: Rafael Fonseca <fonsecasantos.rafael@gmail.com>
Date: Tue, 8 May 2012 14:02:52 -0300
Message-ID: <CAPsQmjpr=m0JHFp-Dv6tuiGYSiJGLdHHY98eAE7NNdCt94rO8A@mail.gmail.com>
Subject: Re: Google Summer of Code 2012 - Introduction
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

it's time for reporting my progress in these first two weeks.

I've actually done less than I expected since my second bluetooth
dongle has not arrived yet, making it difficult for me to test and
better understand the AVRCP profile implementation. Meanwhile, I'm
studying the source code and learning how to use some debugging tools,
like dbus-monitor, hcidump and d-feet.

As suggested by Luiz, I will implement the MediaPlayer interface for
devices supporting AVRCP > 1.3 in the media.c file. The first step is
to change our record to 1.3 and check remote's device record.

Any suggestions or comments are welcome!


Best Regards
-- 
Rafael Fonseca
