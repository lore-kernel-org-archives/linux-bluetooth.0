Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 16:49:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] tools: Add script for updating
 bt_compidtostr() implementation
Message-ID: <20130430134917.GA19739@x220.P-661HNU-F1>
References: <1365706752-4442-1-git-send-email-anderson.lizardo@openbossa.org>
 <20130430100655.GB5745@x220.ger.corp.intel.com>
 <CAJdJm_N8kZEo5ek=6VGDhcdkQhM72O-aKE=fgX=i9UTL18=5iA@mail.gmail.com>
 <CAJdJm_OXMeRQfc7sAdnhUs9qtWO1SaEEezHVJrbu8vTP-s8n8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_OXMeRQfc7sAdnhUs9qtWO1SaEEezHVJrbu8vTP-s8n8g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Apr 30, 2013, Anderson Lizardo wrote:
> On Tue, Apr 30, 2013 at 8:32 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
> > Hi Johan,
> >
> >> I tried this script but after downloading the page it fails with "Input
> >> recoding failed due to invalid input sequence." and then proceeds with
> >> generating a diff to remove all entries from the switch statement.
> 
> I think I found the culprit, it's some problem related to Unicode handling:
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=545695
> 
> There are a few unicode characters on the HTML, I'll remove them
> before passing the HTML file to html2test.

Sounds like a plausible explanation. FWIW, I'm running html2text from
Fedora 18: "This is html2text, version 1.3.2a".

Johan
