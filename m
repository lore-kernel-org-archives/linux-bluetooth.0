Return-Path: <cyrus@holtmann.org>
From: "Peter Krystad" <pkrystad@codeaurora.org>
To: "'Andrei Emeltchenko'" <andrei.emeltchenko.news@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org> <20111026073641.GA11385@aemeltch-MOBL1>
In-Reply-To: <20111026073641.GA11385@aemeltch-MOBL1>
Subject: RE: [PATCH bluez 0/2] Add BT 3.0+HS signalling definitions
Date: Wed, 26 Oct 2011 10:44:51 -0700
Message-ID: <000001cc9406$f707f430$e517dc90$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,
 
> Patches looks OK (taking that typedef is a standard way in bluez).
> 
> The only note: I think that we need to differentiate AMP and A2MP. When we
> are dealing with A2MP protocol we could name structures / functions as
> a2mp_*

I tried to follow the convention of the spec, which uses A2MP only when
referring to the protocol as a whole and when referring to the feature mask
and the fixed channel. It uses AMP or 'AMP Protocol' in all other places,
including individual protocol elements.

Consider this, and if you still think it should be a2mp_ I'll do it.
 
Peter.

--Peter Krystad
  Employee of Qualcomm Innovation Center, Inc.
  Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


