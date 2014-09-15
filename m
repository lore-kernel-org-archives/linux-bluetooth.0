Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+d0B1ecR1P328=X6+PVOHGuMQFV9Es82_-uDBP=b1TMw@mail.gmail.com>
References: <1410211320-16111-1-git-send-email-roylee@paypal.com>
	<CABBYNZ+d0B1ecR1P328=X6+PVOHGuMQFV9Es82_-uDBP=b1TMw@mail.gmail.com>
Date: Mon, 15 Sep 2014 11:23:17 -0700
Message-ID: <CAEvN+1h=p3Jy0sH+8=i1z=DHF7_5OHpww2gHWwTOuTCfUpSESw@mail.gmail.com>
Subject: Re: [PATCH 1/3] tools: Fix usage for hciattach command
From: Tzu-Jung Lee <roylee17@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Sep 15, 2014 at 12:00 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Tue, Sep 9, 2014 at 12:21 AM,  <roylee17@gmail.com> wrote:
>> From: Tzu-Jung Lee <roylee17@gmail.com>
>>
>> ---
>>  tools/hciattach.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/hciattach.c b/tools/hciattach.c
>> index 1904ac5..542b5b3 100644
>> --- a/tools/hciattach.c
>> +++ b/tools/hciattach.c
>> @@ -1276,7 +1276,7 @@ static void usage(void)
>>  {
>>         printf("hciattach - HCI UART driver initialization utility\n");
>>         printf("Usage:\n");
>> -       printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
>> +       printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [sleep|nosleep] [bdaddr]\n");
>>         printf("\thciattach -l\n");
>>  }
>>
>> --
>> 2.0.4
>
> It doesn't look like you are doing anything with sleep|nosleep here,
> also you should probably a add more information regarding what it is
> fixing.
>

I probably should have separated these 3 patches to 2 different sets
though they are all trivial fixes.


The first one attempts to reveal the missing [speed | nospeed] to the user:

Currently, the argument parsing code in the hciattach.c expect very
specific order of the arguments:

    hciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed]
<tty> <type | id> [speed] [flow|noflow] [bdaddr]

For example, if an user would like to specify the BDADDR, none of the
following works:

    hciattach TTY any BDADDR
    hciattach TTY any SPEED BDADDR
    hciattach TTY any SPEED NOFLOW BDADDR

The user has to put the BDADDR exactly in the 4th argument after <type
| id>, ex:

    hciattach TTY any SPEED NOFLOW NOSLEEP BDADDR

And this is impossible to figure out without looking at the source code.
The patch only helps a little (hope so) by revealing the missing
argument to the user.

    hciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed]
<tty> <type | id> [speed] [flow|noflow] [sleep|nosleep] [bdaddr]

Though I do agree the information is still too little, and we probably
should rewrite the argument parsing code to remove the enforcement of
order.
Otherwise, the precise usage syntax for the current logic should be:

   hciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty>
<type | id> [speed]
   hciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty>
<type | id> [speed flow|noflow]
   hciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty>
<type | id> [speed flow|noflow] sleep|nosleep]
   hciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty>
<type | id> [speed flow|noflow sleep|nosleep bdaddr]

Even though, user still need to figure out what suppose to be put in
the flow/sleep if he only wants to change the bdaddr without changing
other default settings.


The second patch speed up the firmware loading speed by raising the
UART baudrate before (and after) loading firmware.
This helps our project reduce the hciattach from 7+ seconds, to 750 ms.
The tricky part for the controller is that it drops the UART back to
115200 after firmware loading.
So we still need to update the baudrate again after firmware is loaded.

Thanks.
Roy

> --
> Luiz Augusto von Dentz
