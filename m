Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH v5 0/6] Support for out of band association model
Date: Fri, 4 Mar 2011 19:51:43 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
References: <1299251315-2041-1-git-send-email-szymon.janc@tieto.com> <AANLkTinhJ2Omcj2s5Um8ARxhG1fVcwEEqH8uF-=dioMx@mail.gmail.com>
In-Reply-To: <AANLkTinhJ2Omcj2s5Um8ARxhG1fVcwEEqH8uF-=dioMx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201103041951.43898.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > Whats in the patchset:
> > - for new kernels implementation in mgmtops
> >  (with kernel patches from "[PATCH v2 0/4] Support for OOB in mgmt interface")
> > - for compatibility with older kernels implementation in hciops (mimic mgmt)
> > - D-Bus plugin only exposes OOB functionality. In future we could also have
> >  CreateOOB[Paired]Device (or similar) which would act as
> >  AddRemoteOobData+CreateDevice.
> 
> What happened to the idea of changing CreateDevice to take a
> dictionary as we discussed in irc? I guess this is the main point of
> the OOB since with this implementation any process can overwrite the
> OOB data of a remote device which is not safe, once we have OOB we
> should try to pair to check if the data is really valid. The drawback
> is that it breaks the current API but I guess we should be focusing on
> BlueZ 5.x pretty soon.

We can still have CreateDevice to take a dictionary along with 'direct' API.
Keep in mind that OOB data can be used in incoming pairing request as well so
a way to provide OOB data for that is needed too.

As for security reason we can limit access to those methods to registered agent
only but I'm not sure if that would improve security if one has already bogus
program running (i.e. it can register itself as agent, possibly after killing agent
process)

-- 
BR,
Szymon Janc
