Return-Path: <cyrus@holtmann.org>
Message-ID: <521CB03B.1030003@ahsoftware.de>
Date: Tue, 27 Aug 2013 15:57:15 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Peter Hurley <peter@hurleysoftware.com>
CC: gustavo@padovan.org, Gianluca Anzolin <gianluca@sottospazio.it>,
 marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.cz
Subject: Re: [PATCH v5 0/6] rfcomm: Implement rfcomm as a proper tty_port
References: <1375110493-5237-1-git-send-email-gianluca@sottospazio.it> <51F94E67.3040402@hurleysoftware.com> <52127E0A.6060208@hurleysoftware.com>
In-Reply-To: <52127E0A.6060208@hurleysoftware.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Am 19.08.2013 22:20, schrieb Peter Hurley:
> On 07/31/2013 01:50 PM, Peter Hurley wrote:

>> I reviewed these changes and retested. All ok.
> 
> Gustavo,
> 
> This series fixes a crashing regression from 3.10+ forward.
> Why is this not in linux-next yet?

3.8+ to be exact, just in case someone has to deal with older kernels.

Regards,

Alexander Holler
