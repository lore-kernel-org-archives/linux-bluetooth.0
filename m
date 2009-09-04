Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Sep 2009 18:56:12 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Peter Hurley <phurley@charter.net>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [4.48] SDP Discovery not reset on error
Message-ID: <20090904155536.GA5889@jh-x301>
References: <4AA08357.7050903@charter.net> <20090904063104.GA23278@jh-x301> <4AA13234.5060909@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AA13234.5060909@charter.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Fri, Sep 04, 2009, Peter Hurley wrote:
> I hadn't moved to 4.52 yet because I'm still trying to track down what I
> think is a race condition in avdtp.

Actually that should be an even more important reason to move to 4.52
since there's at least one AVDTP race condition fix there.

Johan
