Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ v1 4/7] shared/gatt-client: Handle incoming not/ind PDUs.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25SZm1MYn8iaMzJW=GJOOQQo6rE4cNZZJNJGo1MXefkHEg@mail.gmail.com>
Date: Tue, 9 Sep 2014 19:04:05 -0700
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <945AC81C-B24F-4CAA-97B5-B440E5FAEDFC@holtmann.org>
References: <1410282249-22004-1-git-send-email-armansito@chromium.org> <1410282249-22004-5-git-send-email-armansito@chromium.org> <B3B84C22-937B-4880-B59F-0CFA680192D1@holtmann.org> <CAHrH25SVxPLYdjAGNHSwOKLx60wUOSRTzBTHDJfmvpFkiFhRPA@mail.gmail.com> <20140910002954.GA7572@t440s> <CAHrH25SZm1MYn8iaMzJW=GJOOQQo6rE4cNZZJNJGo1MXefkHEg@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>>>> +     unsigned int notify_id, indic_id;
>>>> 
>>>> I have never seen indication shorted into indic. I have to say that
>>>> I do not like it that much. However I do not have any good
>>>> suggestion either.
>>>> 
>>> 
>>> Perhaps "indicn_id"? I could just spell out "indication_id" :P.
>> 
>> What's wrong with "ind"? It's used in many places in the tree as a
>> shorthand for indication and even shared/att.c uses it. On the other
>> hand if you want to match the grammatical form of notify_id you should
>> use indicate_id (which feels much worse to me). Third option that comes
>> to mind if we want short versions of both is "ind" and "nfy", but not
>> sure how decipherable the latter is.
>> 
> 
> I initially had "ind" for indication and "not" for notification (which
> seemed to be consistent with other places in the code, as you said),
> though Marcel didn't like those :P I guess "ind" isn't super
> suggestive of "indication" and, as Marcel pointed out earlier, "not"
> is easily confused as "negation" rather than "notification.

lets go with ind_id and notify_id for now. We can always change this later and I do not want to hold up merging patches because of that. It is just that the not_id and not_* is something that makes my brain always go into the negation first and that is not good coding style.

> I personally prefer not to shorten them at all and spell out
> "notification_id" and "indication_id", which I find the most readable.
> I only started contracting things after mailing list feedback saying
> not to use long names.

We need to be careful with super long names since they can be nice and explanatory in some cases, but in other cases they cause large indentation and weird line breaks which then turns that code into unreadable mess. So this is something you have to weight against each other. This is not black and white, and the right answer is normally what makes code the most readable.

Regards

Marcel

