Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Mar 2013 12:25:57 -0500
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio: Track connections to AVRCP roles separately
Message-ID: <20130315172557.GA13970@x220>
References: <1363365990-1901-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363365990-1901-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Mar 15, 2013, Luiz Augusto von Dentz wrote:
> -void audio_control_connected(struct btd_device *dev, int err);
> -void audio_control_disconnected(struct btd_device *dev, int err);
> +void audio_target_connected(struct btd_device *dev, int err);
> +void audio_target_disconnected(struct btd_device *dev, int err);
> +void audio_remote_connected(struct btd_device *dev, int err);
> +void audio_remote_disconnected(struct btd_device *dev, int err);

Otherwise the patch looks ok'ish but the term "remote" is a bit
confusing to me since I immediately think about "remote device". Would
"controller" or simply "ct" and "tg" be better?

Johan
