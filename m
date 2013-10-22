Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20131021161859.GA9153@x220.p-661hnu-f1>
References: <1382364136-13665-1-git-send-email-jerzy.kasenberg@tieto.com>
	<20131021161859.GA9153@x220.p-661hnu-f1>
Date: Tue, 22 Oct 2013 09:42:04 +0200
Message-ID: <CAHCYCoyszrDFjxZA8yini=QY4A0zOP6msZPGG3WHs0C2mfjUHg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add basic commands to haltest
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 21 October 2013 18:18, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jerzy,
>
> On Mon, Oct 21, 2013, Jerzy Kasenberg wrote:
>> - Adds handling of Ctrl-c Ctrl-d as requested
>> - Prompted changed to includ space
>> - Added commands: quit exit help
>> - Added completion for help
>> - Terminal settings restored on exit
>>
>> Jerzy Kasenberg (3):
>>   android: Add space in prompt in haltest
>>   android: Add handling of Ctrl-c to haltest
>>   android: Add help and quit to haltest
>>
>>  android/client/haltest.c       |  151 ++++++++++++++++++++++++++++++++++------
>>  android/client/if-main.h       |    6 ++
>>  android/client/tabcompletion.c |  151 ++++++++++++++++++++++++++++------------
>>  android/client/terminal.c      |  100 ++++++++++++++++++--------
>>  4 files changed, 312 insertions(+), 96 deletions(-)
>
> Patches 1 and 3 have been applied. It seems we had a bit of a
> misunderstanding about 2 though. I was looking for ctrl-d (i.e. EOF)
> support. Sorry for not being more precise here. Right now when I try
> it the following just happens:
>
> jh@x220:bluez{master}$ android/haltest
>> char-0x04

Patch 2 handles Ctrl-c and Ctrl-d.
When I tried on two terminals in bash Ctrl-d act like delete if line
is not empty.
(this is emax style). When line is empty it terminates.
You or Szymon asked me to add Ctrl-c to clear current line like in other tools.
So maybe it wold be better to put Ctrl-d in patch title instead of Ctrl-c

>
> I wouldn't have expected this to be an issue if stdin is processed
> properly, but it seems even something like the following doesn't result
> in the expected behavior right now (to run all commands in the file and
> then exit the tool):
>
> $ tools/haltest < my-script.txt

This I haven't tried yet so this will probably not work.
But I can handle it some other way not related to Ctrl-d (later :)).

>
> Another thing I'd like to see fixed is getting the terminal back to a
> sane state when exiting. Right now even after a clean exit I seem to
> have to do a hard terminal reset to get normal behavior back. As an
> example, the following is what I get after cleanly exiting using "exit"
> and then pressing enter a couple of times:
>
> jh@x220:bluez{master}$ android/haltest
>> exit

This  is what patch 2 handles by setting atexit() cleanup function that restore
terminal settings. Before there was exit command, ctrl-c did it automatically.

> jh@x220:bluez{master}$ jh@x220:bluez{master}$ jh@x220:bluez{master}$
>
> Johan


-- 
Jerzy Kasenberg
