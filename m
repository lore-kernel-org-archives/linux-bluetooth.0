Return-Path: <cyrus@holtmann.org>
Message-ID: <512B9874.60101@monom.org>
Date: Mon, 25 Feb 2013 17:59:32 +0100
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: Randy Yates <yates@digitalsignallabs.com>
CC: Bluez Mailing List <linux-bluetooth@vger.kernel.org>
Subject: Re: fd argument in NewConnection() Method (profile-api.txt)
References: <874nh1t1qq.fsf@randy.site>
In-Reply-To: <874nh1t1qq.fsf@randy.site>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Randy,

On 25.02.2013 06:13, Randy Yates wrote:
> How can the bluez stack, which runs in its own process, generate a file
> descriptor and hand that fd over to another process (the bluetooth
> profile server process)? I was under the impression that fds can not be
> passed across processes.
>
> bluez 5.2

Have a look at the section talking about SCM_RIGHTS in 'man 7 unix'

hth,
daniel
