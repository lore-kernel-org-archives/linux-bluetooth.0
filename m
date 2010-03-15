Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Mar 2010 08:34:27 +0000 (GMT)
To: Peter Dons Tychsen <donpedro@tdcadsl.dk>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: HCI_MAX_DEV is a bit too small.
In-Reply-To: <1268619078.6278.10.camel@donpedro>
References: <1268608837.6400.26.camel@donpedro>  <1268609659.3897.56.camel@localhost.localdomain> <1268619078.6278.10.camel@donpedro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1268642067.696573.16664.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 15 Mar 2010, Peter Dons Tychsen wrote:

> > So I could be convinced to add new functions to read/write the limit
> > from within an application itself. So that it can be changed without
> > re-compiling the library. Feel free to propose a patch.
>
> I will see what i can do. What is needed is probably a
> hci_set_max_devices() call. Then hcitool could call that with the number
> of devices needed.

A suggestion. I have used this construct in the past for something that
contains a hard coded limit where somebody might want to override it
without rebuilding, and requires no change to the API..

hci.h:
#define HCI_MAX_DEV	hci_max_dev()

hci.c:
unsigned int
hci_max_dev(void)
{
	static unsigned int max = 0;
	char *env, *ep;
	unsigned long v;

	if (max == 0) {
		max = 16;

		env = getenv("HCI_MAX_DEV");
		if (env == NULL)
			break;

		errno = 0;
		v = strtoul(env, &ep, 0);
		if (env[0] == '\0' || *ep != '\0')
			break;

		if (errno == ERANGE && v == ULONG_MAX)
			break;

		if (v > UINT_MAX)
			break;

		max = v;
	}

	return max;
}

regards,
iain
