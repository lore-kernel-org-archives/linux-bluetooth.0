Return-Path: <cyrus@holtmann.org>
Message-ID: <745591.47999.qm@web52606.mail.re2.yahoo.com>
References: <367108.65360.qm@web52604.mail.re2.yahoo.com>  <2d5a2c101002260041n472b3d23m10f9048f69ea1b23@mail.gmail.com>  <1267806674.22567.4.camel@localhost.localdomain>  <768077.72808.qm@web52601.mail.re2.yahoo.com> <2a9506371003051135v3bf107dct36cc9ab71a213326@mail.gmail.com>
Date: Fri, 5 Mar 2010 11:51:07 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: Re: obexd 0.14 "put" file corruption
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
In-Reply-To: <2a9506371003051135v3bf107dct36cc9ab71a213326@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Vinicius,
>  Care to send a patch against the current git?

   I love to, but I don't know how to generate the patch and setup git?. 
      
  The delta is  on  client/session.c   put_xfer_progerss(..)
- memmove(session->buffer + written, session->buffer, session->filled);
+ memmove(session->buffer, session->buffer + written,  session->filled);

Could you help me put it into the source.
If you are kind enough to point me a link to setup the git and generate a patch, I could be ready next time.


Ed



      __________________________________________________________________
Make your browsing faster, safer, and easier with the new Internet Explorer® 8. Optimized for Yahoo! Get it Now for Free! at http://downloads.yahoo.com/ca/internetexplorer/
