Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300812150716y7ac88ee5y19baf38a4d91bcfb@mail.gmail.com>
Date: Mon, 15 Dec 2008 08:16:58 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point encoding
Cc: "Jaska Uimonen" <jaska.uimonen@nokia.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200812151454.19090.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
	 <200812121914.48340.siarhei.siamashka@nokia.com>
	 <d89ddf300812121119o601fe1acs229741960a98835c@mail.gmail.com>
	 <200812151454.19090.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Siarhei

I like your idea of using a macro with the original floating point
tables, as long as we know it is done at compile time, not runtime :)

> Can anybody try to remember/explain what transformations were applied to
> the existing fixed point implementation?

it was done by several people and the only record we have is in cvs.
(part of it is in the old btsco project's cvs)

-- 
Brad Midgley
