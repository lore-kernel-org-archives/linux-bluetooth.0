Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300901020827w20c48a5fgb37d35ff33ea5fd3@mail.gmail.com>
Date: Fri, 2 Jan 2009 09:27:33 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200901021807.17443.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200812311803.45279.siarhei.siamashka@nokia.com>
	 <1230800283.4530.3.camel@californication>
	 <200901021807.17443.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Siarhei

> I wonder what CPU architectures are the most important for bluez?

This is not an easy question, but one perspective is to consider the
impact on battery life. Running sbc encoding on a phone will have a
greater impact on battery life than it does to run it on a laptop.

The ideal is to have portable devices mitigate this with dsp hardware,
but we can't count on the hardware or the driver to be there in all
cases. (see https://garage.maemo.org/projects/dsp-sbc/ for some work
using the TI dsp)

-- 
Brad Midgley
