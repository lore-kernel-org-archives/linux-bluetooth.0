Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1426858595-29346-1-git-send-email-bharat.panda@samsung.com>
 <022501d0654c$9ee015b0$dca04110$@samsung.com>
 <CABBYNZLzrFhgq7K6DdFCMUg0AaQpj5RmGWDCZcZS_K3-HN8q7A@mail.gmail.com>
In-reply-to: <CABBYNZLzrFhgq7K6DdFCMUg0AaQpj5RmGWDCZcZS_K3-HN8q7A@mail.gmail.com>
Subject: RE: [PATCH v2] monitor: Add AVDTP support to btmon
Date: Mon, 23 Mar 2015 20:26:33 +0530
Message-id: <022f01d06579$955ccec0$c0166c40$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> +
> >> +void avdtp_packet(const struct l2cap_frame *frame) {
> >> +     struct l2cap_frame *l2cap_frame;
> >> +     struct avdtp_frame avdtp_frame;
> >> +     const char *pdu_color;
> >> +
> >> +     l2cap_frame_pull(&avdtp_frame.l2cap_frame, frame, 0);
> >> +
> >> +     l2cap_frame = &avdtp_frame.l2cap_frame;
> >> +
> >> +     avdtp_frame.tsid = 0x00;
> >> +     if (!l2cap_frame_get_u8(l2cap_frame, &avdtp_frame.hdr) ||
> >> +                     !l2cap_frame_get_u8(l2cap_frame,
> >> &avdtp_frame.tsid)) {
> >> +             print_text(COLOR_ERROR, "frame too short");
> >> +             packet_hexdump(frame->data, frame->size);
> >> +             return;
> >> +     }
> 
> It looks like you are treating all frames as signalling but A2DP uses the same
> PSM for streaming so I wonder if you have tried this with an active stream?
Yes, I was testing it through mecApp, so couldn't test the real media streaming of the same.
I agree, it is treating all frames as signaling frames, which is how it should not be. I will submit another version for this patch handling the same.
> 

Thanks
Best Regards,
Bharat

