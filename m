Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+Nx9iWAYEJiZY5CSE8x_ynjRFpfawB5c-6+eCKNOHcwg@mail.gmail.com>
References: <1412629304-3391-1-git-send-email-armansito@chromium.org>
	<1412629304-3391-5-git-send-email-armansito@chromium.org>
	<CABBYNZ+Nx9iWAYEJiZY5CSE8x_ynjRFpfawB5c-6+eCKNOHcwg@mail.gmail.com>
Date: Mon, 13 Oct 2014 13:57:46 -0700
Message-ID: <CAHrH25SzRsikERavxBtwcq_tyUtj7BCCg_u4hznLsPOh_Nh+qQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 4/4] shared/gatt-server: Support Read By Group
 Type request.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Arman Uguray <armansito@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


>> +       if (queue_isempty(q)) {
>> +               ecode = BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND;
>> +               goto error;
>> +       }
>
> This function is quite long, perhaps using queue_foreach be better
> than iterating inline since you destroy the queue at end but it would
> be a problem if one of items fails to be encoded, the funny thing is
> that it is possible to do the same with queue_find and return true to
> interrupt in case of failure but it would be a obvious abuse of the
> API so perhaps queue_foreach_func_t could have a return as well and in
> case it return false we stop.
>

I would have to modify too many places that use queue_foreach by
adding a somewhat suspicious "return true" with no obvious meaning, so
I decided not to do that for this patch set. For v2 I went ahead and
broke the encoding bit into its own helper which I plan to extend in
the future for other read requests. Hopefully this'll make the code
more readable although it doesn't call queue_foreach.

Cheers,
Arman
