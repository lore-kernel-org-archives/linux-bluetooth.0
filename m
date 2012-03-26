Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332775508-32693-1-git-send-email-chen.ganir@ti.com>
References: <1332775508-32693-1-git-send-email-chen.ganir@ti.com>
Date: Mon, 26 Mar 2012 17:31:02 -0300
Message-ID: <CAKT1EBd1U84xBox39_eTyccWwiBd1X8UttiHsYB1fAyNQ1LTnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add DeviceInformationService plugin
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen Ganir:

On Mon, Mar 26, 2012 at 12:25 PM,  <chen.ganir@ti.com> wrote:
> From: Chen Ganir <chen.ganir@ti.com>
>
> Add Device Information Service GATT Client for reading peer
> device PNP_ID and store it.
>
> This is v2 of the patch set, removing some unused code to
> eliminate compilation warnings.

I am afraid of race conditions between HoG and DIS services.

ATT is a "serial" protocol, however there is no guarantee that PNP ID
characteristic value will be available before creating uhid device. It
depends on the probing order AND when the commands are added in the
GAttrib queue.

IMO, the alternatives are:
1. move the DIS/PnP discovery to the create device "procedure"
2. create plugin states and dependency before probing
3. uuid "notification" mechanism": callback gets called when a new
value is available for a given characteristic

Opinions?

BR,
Claudio
