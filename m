Return-Path: <cyrus@holtmann.org>
Message-Id: <14CF8002-9C68-48AF-AAB7-783C16CAC8CA@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <48EA93F7.4060000@pook.es>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: bluez/git + 2.6.27-rc8 + bluetoothd -> SIGSEGV
Date: Tue, 7 Oct 2008 07:34:38 +0200
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net>	 <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com>	 <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>	 <0ED1CF2A-40D0-4A82-BAED-21F90B6466ED@gmail.com> <48EA6D84.7020101@pook.es>	 <632D4195-1EFF-4191-98D9-4A0953223590@gmail.com> <48EA7B66.1050208@pook.es>	 <1223326990.11272.229.camel@violet.holtmann.net> <48EA7ED9.9080801@pook.es> <1223328106.11272.232.camel@violet.holtmann.net> <48EA93F7.4060000@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

On Oct 7, 2008, at 0:40, Stuart Pook wrote:
>>> :; grep ' -g' Makefile
>>> CFLAGS = -Wall -O2 -D_FORTIFY_SOURCE=2 -fPIC -g -O0
>> that is indeed strange. You should be able to get a proper backtrace.
>
> yes. I ran src/.libs/bluetoothd, it core dumped,
> but I still cannot get a reasonable backtrace. Weird.

Please do a "git pull". The segfault shouln't occur anymore (a  
probable cause of it was a bug in common/glib-helper.c which Luiz  
fixed yesterday). Also, if you have the chance come to the #bluez  
channel on freenode where most bluez developers hang out (you'd have  
e.g. found out about the fix much earlier that way).

Johan
