Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111112183753.GA17859@x220.Elisa>
References: <1320925022-21891-1-git-send-email-sancane@gmail.com>
	<1320925022-21891-2-git-send-email-sancane@gmail.com>
	<1320925022-21891-3-git-send-email-sancane@gmail.com>
	<20111112183753.GA17859@x220.Elisa>
Date: Sun, 13 Nov 2011 10:18:33 +0100
Message-ID: <CACLukzKZw03P1jXmtGQqFWQ9FJT5JJhuYpcoOsA4nK+6Ded21A@mail.gmail.com>
Subject: Re: [PATCH 2/6] Parse final measurement indication
From: Santiago Carot <sancane@gmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

2011/11/12 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Santiago,
>
> On Thu, Nov 10, 2011, Santiago Carot-Nemesio wrote:
>> +struct measurement {
>> +     gint16          exp;
>> +     gint32          mant;
>> +     guint64         time;
>> +     gboolean        suptime;
>> +     gchar           *unit;
>> +     gchar           *type;
>> +     gchar           *msmnt;
>
> Is msmnt supposed to be short for measurement? Could you just spell it
> out please since to me that short version is far from obvious. Or would
> "value" be a more suitable name?
>

Yes, that's supposed to be a kind of short for measurement, There's
not problem to me in changing the name. The reason why I set that name
was because I wanted to keep consistancy with the thermomether
documentation in which we called it measurement.

> Also, please avoid usage of g* types where you're not directly accessing
> some GLib API that expects them (even then it's mostly fine to go ahead
> with uint16_t, char, etc). I can see that there are other places in
> thermometer.c using the g types too which should be fixed in a separate
> patch.
>

Ok, I used only glib types because I was confused about when I should
use these or the other types, Having a look at some parts in BlueZ it
seemed a little mess, but now It's clear to me. Thank you for your
explanation,
If you dont mind I would preffer to send a separate patch fixing that
issue at the end of the new set in order to avoid too many conflicts
rebasing in my local tree.

>> +static gchar *temptype2str(uint8_t value)
>> +{
>> +     switch (value) {
>> +     case 1: return "Armpit";
>> +     case 2: return "Body";
>> +     case 3: return "Ear";
>> +     case 4: return "Finger";
>> +     case 5: return "Intestines";
>> +     case 6: return "Mouth";
>> +     case 7: return "Rectum";
>> +     case 8: return "Toe";
>> +     case 9: return "Tympanum";
>> +     default:
>> +             error("Temperature type %d reserved for future use", value);
>> +             return NULL;
>> +     };
>
> Please follow the coding style with switch statements. All those return
> statements should be on their own line. However, in this case I think
> it'd be just easier to make a lookup table for those values, i.e.
>
> const char *temp_type[] {
>        "<unknown>",
>        "Armpit",
>        "Body",
>        ...
>
> And then in the temptype2str function:
>
>        if (type > 0 && val < G_N_ELEMENTS(temp_type))
>                return temp_type[type];
>
>
> Johan
>

Ok, I'll redo these patches.
Thanks a lot for your comments.

Santiago
