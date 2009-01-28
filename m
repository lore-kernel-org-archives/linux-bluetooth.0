Return-Path: <cyrus@holtmann.org>
Subject: Re: Disconnect eSCO link from Command line
From: Marcel Holtmann <marcel@holtmann.org>
To: sreevani medhahal <sreevani.medhahal@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <c2a31c480901280137y33faa44fm975c63f5ae2ab514@mail.gmail.com>
References: <c2a31c480901272116y2bd70ed3yf1c02009c1ec0fd0@mail.gmail.com>
	 <1233121193.18259.6.camel@violet>
	 <c2a31c480901280137y33faa44fm975c63f5ae2ab514@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 10:57:47 +0100
Message-Id: <1233136667.2139.1.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sreevani,

> >>   After the headset has created the eSCO link. The Profile Tuning
> >> Suite asks for Closing the Audio Connection from AG. Is there any
> >> command line utiility to disable the eSCO link & not the service level
> >> connection(ACL).[The eSCO link is visible on giving hcitool con ]
> >
> > not that I know of except hcitool cmd ;)
> >
> I tried modifying hcitool.c function cmd_dc by changing type of link
> to ESCO_LINK(instead of ACL_LINK). i got the error as disconnect
> failed operation not permitted.
> > You should also not be sheeting with sending a HCI command when it comes
> > to PTS tests. You program has to be able to disconnect eSCO by itself.
> >
> BlueZ is getting sco_connect result as Connection timed out. but where
> as when i list the connections using hcitool con, i see that there is
> a eSCO link.

you might wanna try bluetooth-testing.git since the SCO/eSCO connection
reject patch might do exactly what you expect here.

Regards

Marcel


