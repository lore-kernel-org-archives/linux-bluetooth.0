Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukz+aP0O_SXLpmA+EadYTFPHEHg6krjj4aqSkpu55ifdFHg@mail.gmail.com>
References: <1321973388-16300-1-git-send-email-sancane@gmail.com>
	<1321973388-16300-2-git-send-email-sancane@gmail.com>
	<1321973388-16300-3-git-send-email-sancane@gmail.com>
	<20111202112649.GB17203@x220.ger.corp.intel.com>
	<CACLukz+aP0O_SXLpmA+EadYTFPHEHg6krjj4aqSkpu55ifdFHg@mail.gmail.com>
Date: Fri, 2 Dec 2011 11:41:52 -0400
Message-ID: <CAJdJm_OzQ-Oe9u8+-=VTp+caaGPrnsteq4yQKO-wDxy40ZrQOQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] Confiure C.C.C descriptor during the thermometer configuration
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Fri, Dec 2, 2011 at 7:52 AM, Santiago Carot <sancane@gmail.com> wrote:
> These are GATT flags to enable/disable indications/notifications in
> client characteristic configuration descriptor, I thought about this
> issue, I haven't seen any macros mapping those values in GATT though.
> I was thinking in sending a separate patch to deal with this issue but
> I saw some Claudio's commits to deal with notification/indications so
> I guess he is already working on it, so I decided no to  interfere and
> wait to see how he is thinking to deal with this stuff.

I think you can create these macros and then begin using it for
thermometer code (feel free to modify generic GATT code to use them as
well).

The commit you are referring to is on one of Claudio's development
branches, right?  That commit will be probably discarded (it is
incomplete, and was just an idea), so feel free to send your own
version. Be sure to take into account that these values are bit masks,
and that maybe we should define all the possible macros for them now.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
