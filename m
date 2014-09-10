Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <20140910002954.GA7572@t440s>
References: <1410282249-22004-1-git-send-email-armansito@chromium.org>
	<1410282249-22004-5-git-send-email-armansito@chromium.org>
	<B3B84C22-937B-4880-B59F-0CFA680192D1@holtmann.org>
	<CAHrH25SVxPLYdjAGNHSwOKLx60wUOSRTzBTHDJfmvpFkiFhRPA@mail.gmail.com>
	<20140910002954.GA7572@t440s>
Date: Tue, 9 Sep 2014 17:48:39 -0700
Message-ID: <CAHrH25SZm1MYn8iaMzJW=GJOOQQo6rE4cNZZJNJGo1MXefkHEg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 4/7] shared/gatt-client: Handle incoming not/ind PDUs.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

HI Johan,

>> >> +     unsigned int notify_id, indic_id;
>> >
>> > I have never seen indication shorted into indic. I have to say that
>> > I do not like it that much. However I do not have any good
>> > suggestion either.
>> >
>>
>> Perhaps "indicn_id"? I could just spell out "indication_id" :P.
>
> What's wrong with "ind"? It's used in many places in the tree as a
> shorthand for indication and even shared/att.c uses it. On the other
> hand if you want to match the grammatical form of notify_id you should
> use indicate_id (which feels much worse to me). Third option that comes
> to mind if we want short versions of both is "ind" and "nfy", but not
> sure how decipherable the latter is.
>

I initially had "ind" for indication and "not" for notification (which
seemed to be consistent with other places in the code, as you said),
though Marcel didn't like those :P I guess "ind" isn't super
suggestive of "indication" and, as Marcel pointed out earlier, "not"
is easily confused as "negation" rather than "notification.

I personally prefer not to shorten them at all and spell out
"notification_id" and "indication_id", which I find the most readable.
I only started contracting things after mailing list feedback saying
not to use long names.

In the end it doesn't matter what these are called if their
declaration is accompanied by an explanatory comment. "ind_id" and
"ntfy_id" look fine to me.

-Arman
