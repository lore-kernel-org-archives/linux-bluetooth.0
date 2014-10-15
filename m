Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLYLDmjM0h2C9-sYOAxsRt4usdgr323bVmj=rF8byvjEw@mail.gmail.com>
References: <1413234602-20566-1-git-send-email-armansito@chromium.org>
	<1413234602-20566-2-git-send-email-armansito@chromium.org>
	<CABBYNZLYLDmjM0h2C9-sYOAxsRt4usdgr323bVmj=rF8byvjEw@mail.gmail.com>
Date: Wed, 15 Oct 2014 10:36:39 -0700
Message-ID: <CAHrH25S-W2gVkeJfsn74VCcD9h2wS86zWDcUVKX=-994pwV76A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] shared/att: Drop the connection if a request is
 received while one is pending.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


>> +       case ATT_OP_TYPE_REQ:
>> +               /* If a request is currently pending, then the sequential
>> +                * protocol was violated. Disconnect the bearer and notify the
>> +                * upper-layer.
>> +                */
>
> It seems this code is not following our coding style regarding multi
> line comments, check doc/coding-style.txt(M2: Multiple line comment)
> the first line should be empty.
>

I didn't realize that was the comment style. I've seen both styles in
daemon code and I think I went with this one because of that. I'd
rather have the code be consistent (since shared/att uses this style
elsewhere) and maybe do a style correction pass in another patch?


>> +               if (att->in_req) {
>> +                       util_debug(att->debug_callback, att->debug_data,
>> +                                       "Received request while another is "
>> +                                       "pending: 0x%02x", opcode);
>> +                       disconnect_cb(att->io, att);
>> +                       return false;
>> +               }
>> +
>> +               att->in_req = true;
>> +
>> +               /* Fall through to the next case */
>
> This might cause a problem with our own code when connecting to each
> other if bt_att_cancel is used, apparently bt_att_cancel does not send
> anything to the remote side which seems to enable sending a new
> request without waiting any response for the first one.
>

I'm confused. Do you mean if bt_att is being used in the client role,
it can send multiple requests this way? That is correct, though I
don't see how that's related to this patch? Currently bt_att_cancel
can be used to cancel waiting for a pending request and send the next
one, as you said. In that regard, it doesn't actually "cancel"
anything if the PDU has been sent over the air already. I don't know
how big of a problem this is, since the remote end should normally
detect the error and terminate the connection anyway. If this becomes
a problem we can always prevent canceling a request that has already
left the queue and is pending. Though, again, this isn't really
related to this patch unless I'm missing something.

Thanks,
Arman
