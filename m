Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Sep 2013 10:48:36 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] android: Android version of log.c
Message-ID: <20130923073733.GB8444@aemeltch-MOBL1>
References: <1379679871-29623-1-git-send-email-frederic.danis@linux.intel.com>
 <1379679871-29623-2-git-send-email-frederic.danis@linux.intel.com>
 <708DB870-5A40-4056-86C8-79092784757C@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <708DB870-5A40-4056-86C8-79092784757C@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Sat, Sep 21, 2013 at 12:20:52PM -0500, Marcel Holtmann wrote:
> Hi Fred,
> > +
> > +static void android_log(int pri, const char *fmt, va_list ap)
> > +{
> > +	char *msg;
> > +	struct iovec vec[3];
> > +
> > +	msg = g_strdup_vprintf(fmt, ap);
> > +
> > +	if (!detached) {
> > +		vec[0].iov_base = (void *) msg;
> > +		vec[0].iov_len = strlen(msg) + 1;
> > +		vec[1].iov_base = "\n";
> > +		vec[1].iov_len = 1;
> > +		writev(STDERR_FILENO, vec, 2);
> > +	}
> 
> Lets not worry about logging to stderr at all.

Then I believe this might be simplified a lot. We might use
__android_log_print - like functions in this case.

Best regards 
Andrei Emeltchenko 

