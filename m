Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: Need help with bug in ftp-client executable from bluez-5.24 package
From: Konrad Antoniuk <konrad18622@gmail.com>
In-Reply-To: <000001d12d0e$a7f505e0$f7df11a0$@samsung.com>
Date: Wed, 2 Dec 2015 14:44:14 -0800
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <FA26AA71-2B3A-43B0-966B-AED90C10DA27@gmail.com>
References: <6AF6FACF-FE0C-446F-9FD1-BBAD20EBF8CC@gmail.com> <CABBYNZKGNtvEGAKT6KL7u2eta=urSQoHZw7x8ChwFA6X4xaxjw@mail.gmail.com> <899EB388-8EE7-449D-850E-C7352B52FDC1@gmail.com> <000001d12d0e$a7f505e0$f7df11a0$@samsung.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

> On Dec 2, 2015, at 6:34 AM, Gowtham Anandha Babu <gowtham.ab@samsung.com> wrote:
> 
> Hi Konrad,
> 
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Konrad Antoniuk
>> Sent: Wednesday, December 02, 2015 6:42 PM
>> To: Luiz Augusto von Dentz
>> Cc: linux-bluetooth@vger.kernel.org
>> Subject: Re: Need help with bug in ftp-client executable from bluez-5.24
>> package
>> 
>> Hello Luiz,
>> 
>>> On Dec 2, 2015, at 2:57 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> 
>>> Hi Konrad,
>>> 
>>> On Wed, Dec 2, 2015 at 10:37 AM, Konrad Antoniuk
>> <konrad18622@gmail.com> wrote:
>>>> Hi,
>>>> 
>>>> I’m looking to resolve an issue with one of the programs from the
>>>> bluez package. I’m using the ftp-client python executable from the
>>>> test folder and having trouble with transferring larger files. I’m
>>>> running the program on the Intel Edison which runs Embedded Linux -
>>>> Yocto. Initially the program worked for smaller files, 6.3 kB in
>>>> size, but when I began experimenting with data files only double the
>>>> size I began to run into trouble. Whenever the dbus signaled and
>>>> called the callback method properties_changed, I initially received
>>>> an error that the global variable value was left uninitialized. I
>>>> solved that problem by adding the line value =
>>>> properties[“Transferred”] at line 98 in the program, just before the
>>>> speed calculation. This removed any reported errors received but the
>>>> larger files still don’t transfer successfully. It seems whenever the
>>>> signal’s callback function completes, the transfer doesn’t continue.
>>>> I’ve attempted to call the Resume method from the Tr
>> ansfer Interface but I must be doing something wrong because I’m fairly
>> new to Python and debugging a program that uses dbus.
>>>> 
>>>> To make it clear, the ftp-client executable from the test folder in the blues
>> package works whenever the file transfer is completed before the Bus
>> signals back. I’ve fixed an uninitialized variable bug but I still can’t get larger
>> files to successfully transfer. I appreciate any guidance in correcting the
>> source code and fixing this bug.
>>> 
>>> Have you tried with obexctl? ftp-client is actually deprecated so
>>> chances are that it doesn't work properly anymore.
>>> 
>>> 
>>> --
>>> Luiz Augusto von Dentz
>> 
>> Thanks for the quick response. I did get obexctl to transfer the larger file for
>> me. However, for my application, I was using ftp-client through a system call
>> within an SPP python program that interpreted my commands from a
>> separate device. In addition, I was able to pass all of my options and
>> arguments with a single shell command using this method. Will I be able to
>> use obexctl the same way or is there another application that will allow me to
>> do the same that isn’t deprecated?
>> 
> 
> Please try out the patch " [PATCH] test: Fix ftp-client not printing progress " which I have sent on ML.
> Hope that solves your problem.
> 
> Regards,
> Gowtham A
> 
>> Thanks,
>> Konrad    --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
> 

It works! Thanks for the help, it’s much appreciated. If it’s not too much trouble, can you or someone explain why additional changes to the preceding if statements made the difference in functionality? Running the original code, I’ve now noticed the additional exceptions printing a couple KeyError messages for the Status property. Why did these errors disappear when I made the undefined variable fix? 

Regards,
Konrad

