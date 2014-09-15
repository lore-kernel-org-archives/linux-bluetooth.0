Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Marcel Holtmann' <marcel@holtmann.org>,
	'Johan Hedberg' <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com
References: <1410331363-3548-1-git-send-email-gowtham.ab@samsung.com>
 <20140912165730.GC3671@t440s>
 <705AF308-550F-47C4-ADD3-9276158CA280@holtmann.org>
In-reply-to: <705AF308-550F-47C4-ADD3-9276158CA280@holtmann.org>
Subject: RE: [PATCH] tools/seq2bseq : Fix the same expression issue in if
 condition
Date: Mon, 15 Sep 2014 11:44:55 +0530
Message-id: <000b01cfd0ac$62bf72e0$283e58a0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi ,

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Friday, September 12, 2014 10:35 PM
> To: Johan Hedberg
> Cc: gowtham babu; linux-bluetooth@vger.kernel.org;
> d.kasatkin@samsung.com; bharat.panda@samsung.com;
> cpgs@samsung.com
> Subject: Re: [PATCH] tools/seq2bseq : Fix the same expression issue in if
> condition
> 
> Hi Johan,
> 
> >> Below are the list of similar patches under 'tools' which are not yet
> >> reviewed
> >>
> >> 1) tools/csr_usb : Fix Resource leak: file
> >> 2) tools/hciattach : Fix syntax error
> >> 3) tools/btsnoop : Fix variable reassigning issue
> >
> > This kind of stuff does not belong in a commit message.
> >
> >> diff --git a/tools/seq2bseq.c b/tools/seq2bseq.c index
> >> 7657a57..521d20e 100644
> >> --- a/tools/seq2bseq.c
> >> +++ b/tools/seq2bseq.c
> >> @@ -40,7 +40,7 @@ static int convert_line(int fd, const char *line)
> >> 	char str[3];
> >> 	unsigned char val;
> >>
> >> -	if (line[0] == '*' || line[0] == '\r' || line[0] == '\r')
> >> +	if (line[0] == '*' || line[0] == '\r')
> >> 		return 0;
> >>
> >> 	while (1) {
> >
> > Are you sure the code wasn't intending to check for '\n'?
> 
> yes, it was intended to check for \r and \n. This is my mistake here.
> 
> Regards
> 
> Marcel

I had fixed this and sent the revised patch. Please have a look at it. 

Regards,
Gowtham 

