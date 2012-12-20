Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Dec 2012 09:55:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Xian Pan <panxian1212@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Question for setting IO capability parameter for RegisterAgent
Message-ID: <20121220075542.GA32641@x220>
References: <679160B2-3B1E-4D5E-978E-E3358F6126E9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <679160B2-3B1E-4D5E-978E-E3358F6126E9@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Xian,

On Wed, Dec 19, 2012, Xian Pan wrote:
> I confuse the relationship between the 4 pairing mode in SSP with the
> IO capability parameter for the agent. From the agent-api.txt file,
> the capability parameter can have 5 values: DisplayOnly, DisplayYesNo,
> KeyboardOnly, NoInputNoOutput and KeyboardDisplay. I think there are
> only 4 pairing mode in SSP: just works, numeric comparison, out of
> band, and passkey entry. How the 5 IO capabilities can map to those 4
> pairing modes?

Low Energy SMP based pairing introduces the additional KeyboardDisplay
IO capability. If you want to support LE it's recommended you provide
that as your agent capability and BlueZ will then automatically
downgrade it to DisplayYesNo for BR/EDR (SSP) pairing and use it as is
for LE SMP pairing.

Johan
