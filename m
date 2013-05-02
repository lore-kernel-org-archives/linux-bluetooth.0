Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130501061016.GA13611@x220.P-661HNU-F1>
References: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi> <20130501061016.GA13611@x220.P-661HNU-F1>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Wed, 1 May 2013 22:10:58 -0300
Message-ID: <CAKi4VA+SATC3_SU+jyBsRzUW=+WOh9Tkizu0EhmZ99nApWHUdg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 01/16] attrib: Get rid of gint
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, May 1, 2013 at 3:10 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lucas,
>
> On Wed, May 01, 2013, Lucas De Marchi wrote:
>> Use plain int instead of gint. In glib gint is always a typedef to int,
>> so it's safe to use it even for callbacks with glib.
>> ---
>>
>> v2: Fix commit message
>>
>>  attrib/gatt-service.c | 2 +-
>>  attrib/gatt.c         | 2 +-
>>  attrib/gattrib.c      | 6 +++---
>>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> All patches in this set have been applied. Thanks.
>
> Johan

Did you forget or  you didn't apply the gchar->char patch set before
this one on purpose?



Lucas De Marchi
