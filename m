Return-Path: <cyrus@holtmann.org>
Message-Id: <632D4195-1EFF-4191-98D9-4A0953223590@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <48EA6D84.7020101@pook.es>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: bluez-4.11 + 2.6.27-rc8 + SCO headset -> Invalid read of size 4
Date: Mon, 6 Oct 2008 22:31:17 +0200
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net> <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com> <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com> <0ED1CF2A-40D0-4A82-BAED-21F90B6466ED@gmail.com> <48EA6D84.7020101@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

On Oct 6, 2008, at 21:56, Stuart Pook wrote:
>> I think I managed to fix the segfault issue. The valgrind backtrace  
>> was actually misleading/incorrect but I managed to get a proper one  
>> with gdb. Could you try the latest git and see if the segfault is  
>> gone?
>
> I still have the segfault. But it took a little longer this time.

Actually it's a different issue than the original segfault (see later  
in this email).

> I'm a git beginner. Is there a git command that gives me the "version"
> of what "git clone" retrieved so that you exactly what code I have?

You won't have any specific version but just the latest development  
tree. Be sure to run "git pull" every now and then to make sure you  
get the latest changes.

> bluetoothd[2451]: connect(): Connection timed out (110)
> ==2451== Invalid read of size 4
> ==2451==    at 0x490CBF3: (within /usr/lib/libdbus-1.so.3.4.0)
> ==2451==    by 0x4911DD1: dbus_message_get_sender (in /usr/lib/ 
> libdbus-1.so.3.4.0)
> ==2451==    by 0x49155C0: dbus_message_new_error (in /usr/lib/ 
> libdbus-1.so.3.4.0)
> ==2451==    by 0x15677: error_common_reply (error.c:42)
> ==2451==    by 0x4ED900D: error_connection_attempt_failed (headset.c: 
> 175)
> ==2451==    by 0x4ED9A3B: sco_connect_cb (headset.c:468)

This is a different trace than the original one. The original one went  
through rfcomm_connect_cb while this one goes through sco_connect_cb,  
i.e. you've already got the (RFCOMM) control connection up and are  
trying to establish the audio (SCO) connection. I will investigate it,  
however could you try to get a backtrace with gdb as well since it  
seems that valgrind either distorts or hides some errors.

Johan



