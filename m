Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 24 Nov 2015 15:16:37 +0100 (CET)
From: acalando@free.fr
To: linux-bluetooth@vger.kernel.org
Message-ID: <354132869.329670308.1448374597432.JavaMail.root@zimbra62-e11.priv.proxad.net>
Subject: Bug in batostr()?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


In lib/bluetooth.c, it looks like batostr() is bugged (wrong bytes order), 
after comparison with ba2str():

char *batostr(const bdaddr_t *ba)
	sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
		ba->b[0], ba->b[1], ba->b[2],
		ba->b[3], ba->b[4], ba->b[5]);

int ba2str(const bdaddr_t *ba, char *str)
	return sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);

This function is not called anywhere else in the repository, that is probably 
why the problem never showed up.

Antoine
