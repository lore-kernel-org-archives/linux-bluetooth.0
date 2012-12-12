Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1355308088-9080-17-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
	<1355308088-9080-17-git-send-email-szymon.janc@tieto.com>
Date: Wed, 12 Dec 2012 09:19:44 -0400
Message-ID: <CAJdJm_PqVbJTQKuqor7-2Dz+gRKTu+Bca7mSMW8PsFj8qW6itw@mail.gmail.com>
Subject: Re: [PATCH 16/16] avctp: Remove double looking for audio device
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Dec 12, 2012 at 6:28 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> There is no need to double call for manager_get_audio_device with
> toggled create flag. manager_get_audio_device with create set to true
> will only create new audio device if matching one was not found.

What's the difference between "manager_get_audio_device(device,
FALSE)" and "manager_find_device(device)" ? Also, would be better to
rename manager_find_device() to manager_find_audio_device()?

Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
