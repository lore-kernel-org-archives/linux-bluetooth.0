Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1399472233-19056-2-git-send-email-lukasz.rymanowski@tieto.com>
References: <1399472233-19056-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1399472233-19056-2-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 7 May 2014 11:15:52 -0700
Message-ID: <CAHZ1yCk593aNDzLAjb3RjoTehYaZgm5BxAnKQQwSY_9Md76+8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: Introduce Start/Stop Connection Monitor
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
> This patch introduce device method to start and stop connection monitor
> and two new device properties ConnectionRSSI and ConnectionTXPower which
> are tracked when monitor is active

Does a polling API like this make more sense than just an "Update
Connection Properties" method call?

Why make new properties? The existing RSSI property could be re-used
without confusion, likewise the TXPower property could be called just
that - which would then give a place to fill in the TX Power if
present in AD as well.

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
