Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv3 2/3] Re-add manager_get_default_adapter()
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org,
	Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>,
	"Pascal A . Brisset" <pascal44973@pabr.org>,
	Marcin Tolysz <tolysz@gmail.com>,
	Christian Birchinger <joker@netswarm.net>,
	Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>,
	Mikko Virkkila <virkkila@kapsi.fi>,
	Simon Wood <simon@mungewell.org>
Date: Thu, 09 Jun 2011 16:10:07 +0100
In-Reply-To: <20110609170011.ad822f40.ospite@studenti.unina.it>
References: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
	 <1307538557-9287-3-git-send-email-ospite@studenti.unina.it>
	 <1307628154.2669.212.camel@novo.hadess.net>
	 <20110609170011.ad822f40.ospite@studenti.unina.it>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1307632211.2669.213.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2011-06-09 at 17:00 +0200, Antonio Ospite wrote:
> On Thu, 09 Jun 2011 15:02:32 +0100
> Bastien Nocera <hadess@hadess.net> wrote:
> 
> > On Wed, 2011-06-08 at 15:09 +0200, Antonio Ospite wrote:
> > > From: Bastien Nocera <hadess@hadess.net>
> > 
> > Sent out a new patch for that which allows the same functionality, but
> > returns an ID instead (you can then get the btd_adapter through existing
> > manager functions).
> 
> OK, so basically I drop 2/3 and do:
> adapter = manager_find_adapter_by_id(manager_get_default_adapter_id());
> right?

Yep. Hopefully my last patch will get in shortly.

