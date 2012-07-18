Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jul 2012 10:47:55 +0200
From: Ludek Finstrle <ludek.finstrle@pzkagis.cz>
To: linux-bluetooth@vger.kernel.org
Subject: obexd - bug in plugins irmc + phonebook-ebook
Message-ID: <20120718084754.GA6496@pzkagis.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

  I find the bug in IrMC + phonebook-ebook. There is function phonebook_pull defined in
phonebook-ebook. There is test for name '/telecom/pb.vcf' but IrMC plugin send name
only 'telecom/pb.vcf'.

I attached simple patch to correct this behaviour. To be honest I tested only
phonebook-ebook.

Best regards,

Luf

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="204_fix_irmc_open_full_path.patch"

diff -cr plugins/irmc.c plugins/irmc.c
*** plugins/irmc.c	Thu May 17 11:12:17 2012
--- plugins/irmc.c	Tue Jul 17 12:25:27 2012
***************
*** 226,232 ****
  	param->maxlistcount = 0; /* to count the number of vcards... */
  	param->filter = 0x200085; /* UID TEL N VERSION */
  	irmc->params = param;
! 	irmc->request = phonebook_pull("telecom/pb.vcf", irmc->params,
  					phonebook_size_result, irmc, err);
  	ret = phonebook_pull_read(irmc->request);
  	if (err)
--- 226,232 ----
  	param->maxlistcount = 0; /* to count the number of vcards... */
  	param->filter = 0x200085; /* UID TEL N VERSION */
  	irmc->params = param;
! 	irmc->request = phonebook_pull("/telecom/pb.vcf", irmc->params,
  					phonebook_size_result, irmc, err);
  	ret = phonebook_pull_read(irmc->request);
  	if (err)
***************
*** 312,318 ****
  
  	if (!g_strcmp0(name, ".vcf")) {
  		/* how can we tell if the vcard count call already finished? */
! 		irmc->request = phonebook_pull("telecom/pb.vcf", irmc->params,
  						query_result, irmc, &ret);
  		if (ret < 0) {
  			DBG("phonebook_pull failed...");
--- 312,318 ----
  
  	if (!g_strcmp0(name, ".vcf")) {
  		/* how can we tell if the vcard count call already finished? */
! 		irmc->request = phonebook_pull("/telecom/pb.vcf", irmc->params,
  						query_result, irmc, &ret);
  		if (ret < 0) {
  			DBG("phonebook_pull failed...");

--u3/rZRmxL6MmkK24--
