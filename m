Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=L7F3AR6bukK-GqBxprCPpy6X9TA@mail.gmail.com>
References: <BANLkTi=LXBzm+9g-VdonozngKhQfOZoz2w@mail.gmail.com>
	<1307957658-11330-1-git-send-email-lkslawek@gmail.com>
	<1307957658-11330-2-git-send-email-lkslawek@gmail.com>
	<BANLkTinFrYNNSj0SL3TT=kCnB3PLS7yeAw@mail.gmail.com>
	<20110615133932.GA14904@dell.ger.corp.intel.com>
	<BANLkTi=U2mgumWCTHBMvtROWn5iAA_fiJw@mail.gmail.com>
	<BANLkTikOJC7QSWkJ2HbJTQg-e2n36mc-zw@mail.gmail.com>
	<BANLkTi=L7F3AR6bukK-GqBxprCPpy6X9TA@mail.gmail.com>
Date: Thu, 16 Jun 2011 11:19:16 +0200
Message-ID: <BANLkTim9dKdFZnNbznkxpa7fvmhKD12o8A@mail.gmail.com>
Subject: Re: [PATCH 3/4] Modify obex_write_stream logic
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Another possibility I see to keep the flexibility and make read() be
used only for Body (as we rather should not add any headers after End
of Body) is to add ->get_header() which would be a general callback to
add any non-body headers plugin wishes to use.

-- 
Slawomir Bochenski
