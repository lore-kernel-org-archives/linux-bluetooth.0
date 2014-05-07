Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1399472233-19056-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1399472233-19056-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 7 May 2014 11:13:19 -0700
Message-ID: <CAHZ1yC=3GQJLcuKV4FwRKcHLY2C5xFsQJh1FVpvabBWTpfWsTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: Update RSSI property description.
From: Scott James Remnant <keybuk@google.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, szymon.janc@tieto.com,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, May 7, 2014 at 7:17 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> RSSI property is inquiry RSSI and this should be stated here especially
> that we plan to add connection RSSI property soon.

Does connection RSSI really need to be a separate property? Why can't
the same property be used for both? It's the same device after all.

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
