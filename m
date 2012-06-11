Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Jun 2012 11:20:51 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Lock l2cap chan in sockopt
Message-ID: <20120611082048.GB29187@aemeltch-MOBL1>
References: <1338993808-30783-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1206081053160.15058@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1206081053160.15058@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Fri, Jun 08, 2012 at 11:02:47AM -0700, Mat Martineau wrote:
> >Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Commit message is quite short :)  (I know, it's just an RFC)

Maybe I need to put one oops dump, but I was not able to reproduce it.

[  745.772484] BUG: unable to handle kernel NULL pointer dereference at
(null)
[  745.774157] IP: [<f828dccc>] l2cap_sock_getsockopt+0x2ec/0x3f0
[bluetooth]
[  745.775077] *pde = 00000000 
[  745.776483] Oops: 0000 [#1] SMP 


Best regards 
Andrei Emeltchenko 
