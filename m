Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100901161402t65173745xd6f83e90a2057ffb@mail.gmail.com>
Date: Fri, 16 Jan 2009 19:02:09 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
Subject: Re: SBC big endian issues?
Cc: "ext Marcel Holtmann" <marcel@holtmann.org>,
	"ext Brad Midgley" <bmidgley@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200901161923.04676.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200901051015.20512.siarhei.siamashka@nokia.com>
	 <200901071440.01872.siarhei.siamashka@nokia.com>
	 <1231335837.5298.0.camel@californication>
	 <200901161923.04676.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

It seems gstreamer does have G_BYTE_ORDER, so you probably don't need
those #ifdef. I also notice some unnecessary white spaces in the of a
line.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
