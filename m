Return-Path: <cyrus@holtmann.org>
Message-Id: <0ED1CF2A-40D0-4A82-BAED-21F90B6466ED@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: bluez-4.11 + 2.6.27-rc8 + SCO headset -> Invalid read of size 4
Date: Mon, 6 Oct 2008 12:52:29 +0200
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net> <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com> <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

I think I managed to fix the segfault issue. The valgrind backtrace  
was actually misleading/incorrect but I managed to get a proper one  
with gdb. Could you try the latest git and see if the segfault is  
gone? Unfortunately this still leaves you with the original issue of  
your player bailing out too early.

Johan
