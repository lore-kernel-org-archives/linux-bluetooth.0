Return-Path: <harbaum@beecon.de>
From: Till Harbaum <harbaum@beecon.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] Fighting with SCO
Date: Fri, 27 Aug 2004 12:21:51 +0200
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200408261852.56641.harbaum@beecon.de> <1093541231.2581.40.camel@pegasus>
In-Reply-To: <1093541231.2581.40.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200408271221.51455.harbaum@beecon.de>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

the problem seems to be PC/USB related. All the dongles work on my laptop 
(based on intels 440bx with uhci), but they all don't work on my sis/ohci 
based desktop.

SCO is enabled for hci_usb on both machines and the sco modules gets loaded. 
The machine having problems is running kernel 2.4.26 with the built-in bluez, 
the notebook is running 2.4.27 

Anyway, i can live with the fact, that only the notebook works. Thanks for you 
help.

Ciao,
  Till

-- 
Dr.-Ing. Till Harbaum                       Tel.:  +49 721 4998963
BeeCon GmbH                                 Fax:   +49 721 4998962
Haid-und-Neu Strasse 7, 76131 Karlsruhe     Mobil: +49 179 9087904
harbaum@beecon.de                           http://www.beecon.de
