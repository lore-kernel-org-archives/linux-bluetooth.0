Return-Path: <cyrus@holtmann.org>
Message-ID: <9219.48556.qm@web111415.mail.gq1.yahoo.com>
References: <2d5a2c100911120508y38dc967aga78c500e20c075d7@mail.gmail.com>  <697456.15025.qm@web111405.mail.gq1.yahoo.com> <2d5a2c100911120529s392e818bk281d09fdee77fa13@mail.gmail.com>
Date: Thu, 12 Nov 2009 06:42:56 -0800 (PST)
From: Mark Stanovich <stanmj@yahoo.com>
Subject: Re: Simultaneous outgoing audio streams
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100911120529s392e818bk281d09fdee77fa13@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz Augusto von Dentz wrote:


> Sorry I just interpret this all wrong, as the application has been
> sending 00:00:00:00:00:00, but yeah you seem to be doing it right
> although Im not sure you can have more than one SCO connection active,
> but that doesn't explain the host is down error, so perhaps there is
> something else blocking you.

I attempted briefly to go through the code and see what exactly is causing the error.  It appears that bluetoothd starts a search for the headset and is unable to find it (or prevented from finding it).  I am unclear why it cannot find the headset when another audio stream is in progress.  It could be that there is some sort of locking mechanism in place.  The code is relatively new to me.  Maybe as you mentioned it is requesting another SCO connection and prevented from creating one with another device?  I will try to dig deeper and see where it is actually getting blocked.

   - Mark



      
