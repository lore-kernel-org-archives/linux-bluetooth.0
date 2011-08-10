Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312985204-10311-1-git-send-email-arkadiusz.lichwa@tieto.com>
References: <1312985204-10311-1-git-send-email-arkadiusz.lichwa@tieto.com>
Date: Thu, 11 Aug 2011 00:57:27 +0300
Message-ID: <CABBYNZ+_qWTodBDTSP+tcZ3Y2TFqStoJy03LsdW1928TAisH7w@mail.gmail.com>
Subject: Re: [PATCH] Fix PTS DID test case TP/SDI/BV-03-I
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arek Lichwa <arkadiusz.lichwa@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 10, 2011 at 5:06 PM, Arek Lichwa <arkadiusz.lichwa@tieto.com> wrote:
> +               uint16_t vid = 0x0000, pid = 0x0000, ver = 0x0000, vid_assigner = 0x0000;
> +               int result = EOF;

Btw, you don't really need to initialize the variable here since you
are assigning the return of sscanf right bellow

> +               result = sscanf(did, "%4hx:%4hx:%4hx:%4hx", &vid_assigner, &vid, &pid, &ver);
> +               if (result != EOF && result > 3) {
> +                       register_device_id(vid_assigner, vid, pid, ver);
> +               } else {
> +                       info("DeviceID record not registered");



-- 
Luiz Augusto von Dentz
