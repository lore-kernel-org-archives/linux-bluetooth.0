Return-Path: <cyrus@holtmann.org>
Message-ID: <51F16C70.2090100@hurleysoftware.com>
Date: Thu, 25 Jul 2013 14:20:32 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
 marcel@holtmann.org
Subject: Re: [PATCH v2 2/7] rfcomm: Move the tty initialization and cleanup
 out of open/close
References: <1374510435-12149-1-git-send-email-gianluca@sottospazio.it> <1374510435-12149-2-git-send-email-gianluca@sottospazio.it> <51F0550A.1000402@hurleysoftware.com> <20130725053725.GA7214@sottospazio.it> <51F1213C.3030900@hurleysoftware.com> <20130725180749.GA12067@sottospazio.it>
In-Reply-To: <20130725180749.GA12067@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/25/2013 02:07 PM, Gianluca Anzolin wrote:
> On Thu, Jul 25, 2013 at 08:59:40AM -0400, Peter Hurley wrote:
>> On 07/25/2013 01:37 AM, Gianluca Anzolin wrote:
>>> Hello,
>>>
>>> sorry I'm not very used to submit patches "the right way" and I missed the
>>> point that I have to keep the changes to the minimum.
>>
>> No need to apologize.
>> Every kernel contributor goes through this learning curve.
>>
>
> Hello,
>
> I'm trying to reach the minimal changeset to reach my target, and in the
> process I figured out that if I implement the .activate and .shutdown port
> methods before the .install and .cleanup methods I could produce less changes.
>
> However I'm stuck now because I cannot guarantee that the intermediate code
> between the patches works at all (however it compiles). What should I do?

The tty .install and .cleanup methods should be introduced first.
Then the tty_port methods.

The dev_list patch should be before both.

If you want, feel free to send me private email with questions and/or
code snippets, and I'll do my best to respond quickly.

Regards,
Peter Hurley
