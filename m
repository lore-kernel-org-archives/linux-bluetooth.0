Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACFh1D5MbZxjrpfjBhy2ENZgk0ACA0s93GBtoFDLeJ_5nEypQA@mail.gmail.com>
References: <CACFh1D5A64SVvKU7FfsMRr8Yz31=-g92Z6k8=NgQjPE1SxsxEg@mail.gmail.com>
 <CACFh1D5MbZxjrpfjBhy2ENZgk0ACA0s93GBtoFDLeJ_5nEypQA@mail.gmail.com>
From: David Narvaez <david.narvaez@computer.org>
Date: Sat, 28 Jun 2014 17:47:29 -0400
Message-ID: <CACFh1D6nFwW18XGMPbQ3Ge1mnysidWBwFccKjU4cDHviGv-yQw@mail.gmail.com>
Subject: Re: SSH Shell Over Bluetooth
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 27, 2014 at 9:59 AM, David Narvaez
<david.narvaez@computer.org> wrote:
> On Thu, Jun 19, 2014 at 9:17 PM, David Narvaez
> <david.narvaez@computer.org> wrote:
>> Hi,
>>
>> I have an RPi with a bluetooth dongle and my ultimate goal is to be
>> able to SSH into the RPi over bluetooth from my laptop. Back in the
>> days, PAND was the way to do this, but now that it is gone I don't see
>> any documentation explaining how to set up TPC/IP over bluetooth.
>
> Ping.

Today I learned that if I do all of the steps I described before and
then remove the bnep0 interface from the bridge, everything works as
expected. So now I am thinking I don't need NAP at all, I just need to
establish a BNEP connection, is there a simpler way to do this?

David E. Narvaez
