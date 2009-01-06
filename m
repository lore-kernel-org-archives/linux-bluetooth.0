Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35c90d960812221613u51133e39x7b18f078c0149d56@mail.gmail.com>
References: <35c90d960812221613u51133e39x7b18f078c0149d56@mail.gmail.com>
Date: Mon, 5 Jan 2009 16:47:37 -0800
Message-ID: <35c90d960901051647x3166e1e2g27cf53c19df48246@mail.gmail.com>
Subject: Re: Tools for AVDTP / AVCTP qualification
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Dec 22, 2008 at 4:13 PM, Nick Pelly <npelly@google.com> wrote:
> Hi,
>
> Do there exist any tools to help pass Bluez AVDTP and AVCTP stack qualification?
>
> Looking at the test spec it seems some command line tools might be
> handy. I am thinking along the lines of l2test, hcitool etc. I'll be
> writing some similar for AVDTP and AVCTP unless there are already some
> floating around?

Following up on this old thread,

The AVDTP and AVCTP SIG test specification documents explain a
complex, automated testing environment where an 'upper tester' makes
method or IPC calls into your stack to cause it to run through various
AVDTP/AVCTP request/responses with the 'lower tester'. This was what
my original email was about - if there were tools to interface with
the upper tester.

What those documents do not explain is that it seems for A2DP and
AVRCP products you can submit frontline sniff traces of the PTS tests
as evidence of AVDTP/AVCTP compatibility. So in our case we don't need
the tools. Hope this helps others trying to wade through SIG
bureaucracy.

Nick
