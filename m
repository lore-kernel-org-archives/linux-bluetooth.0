Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6AF6FACF-FE0C-446F-9FD1-BBAD20EBF8CC@gmail.com>
References: <6AF6FACF-FE0C-446F-9FD1-BBAD20EBF8CC@gmail.com>
Date: Wed, 2 Dec 2015 12:57:28 +0200
Message-ID: <CABBYNZKGNtvEGAKT6KL7u2eta=urSQoHZw7x8ChwFA6X4xaxjw@mail.gmail.com>
Subject: Re: Need help with bug in ftp-client executable from bluez-5.24 package
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Konrad Antoniuk <konrad18622@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Konrad,

On Wed, Dec 2, 2015 at 10:37 AM, Konrad Antoniuk <konrad18622@gmail.com> wrote:
> Hi,
>
> I’m looking to resolve an issue with one of the programs from the bluez package. I’m using the ftp-client python executable from the test folder and having trouble with transferring larger files. I’m running the program on the Intel Edison which runs Embedded Linux - Yocto. Initially the program worked for smaller files, 6.3 kB in size, but when I began experimenting with data files only double the size I began to run into trouble. Whenever the dbus signaled and called the callback method properties_changed, I initially received an error that the global variable value was left uninitialized. I solved that problem by adding the line value = properties[“Transferred”] at line 98 in the program, just before the speed calculation. This removed any reported errors received but the larger files still don’t transfer successfully. It seems whenever the signal’s callback function completes, the transfer doesn’t continue. I’ve attempted to call the Resume method from the Tra
 nsfer Interface but I must be doing something wrong because I’m fairly new to Python and debugging a program that uses dbus.
>
> To make it clear, the ftp-client executable from the test folder in the blues package works whenever the file transfer is completed before the Bus signals back. I’ve fixed an uninitialized variable bug but I still can’t get larger files to successfully transfer. I appreciate any guidance in correcting the source code and fixing this bug.

Have you tried with obexctl? ftp-client is actually deprecated so
chances are that it doesn't work properly anymore.


-- 
Luiz Augusto von Dentz
