Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Jul 2010 12:44:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: ingas@codeaurora.org
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH v4 0/5] Enhanced support for extended inquiry response
Message-ID: <20100726094444.GB20357@jh-x301>
References: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
 <20100723082045.GA1600@jh-x301>
 <20100723082754.GA12563@jh-x301>
 <20100723084300.GA14443@jh-x301>
 <b622ef9ae078ace2da7a8a6748823d2f.squirrel@www.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b622ef9ae078ace2da7a8a6748823d2f.squirrel@www.codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Sun, Jul 25, 2010, ingas@codeaurora.org wrote:
> It seems my comment for this patch submisiion was not specific enough (my
> apologies). The extended support for EIR update was meant for the cases
> when d-bus methods "AddRecord", "RemoveRecord" and "Update Record" were
> called. I did verify the problems that you indicated in EIR update when
> using sdptool. However, this is a pre-existing condition not related to
> the extensions that I submitted. sdptool uses different mechanism for EIR
> update that was not affected by my changes. That needs to be fixed in a
> separate patch set, IMO.

Both the D-Bus interface as well as sdptool trigger the same code paths
in src/sdpd-service.c. I.e. it doesn't make sense to solve this twice
when it can be solved once by targetting the common lower layer. We
already do this for the service class bits with update_svclass_list() in
sdpd-service.c. The need to update the EIR data is very similar to the
need to update the service class bits so the existing code is probably a
good place to take example of.

And yes, please make your commit messages more verbose. It's far less of
a crime to have too verbose messages than not having them descriptive
enough: it doesn't just help the reviewers right now in understanding
the purpose of the patches but will also help anybody looking through
the commit history a few years from now when the details of the matter
have been forgotten.

Johan
