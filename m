Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 6 Feb 2018 15:52:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: linux-bluetooth@vger.kernel.org
Subject: [bug report] missing bounds check reading firmware
Message-ID: <20180206125222.GB9445@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi BT devs,

This looks like it only has a small impact...

	drivers/bluetooth/bt3c_cs.c:491 bt3c_load_firmware()
	warn: overflowed symbol reused:  'size'

drivers/bluetooth/bt3c_cs.c
   467          /* Load */
   468          while (count) {
   469                  if (ptr[0] != 'S') {
   470                          BT_ERR("Bad address in firmware");
   471                          err = -EFAULT;
   472                          goto error;
   473                  }
   474  
   475                  memset(b, 0, sizeof(b));
   476                  memcpy(b, ptr + 2, 2);
   477                  if (kstrtoul(b, 16, &size) < 0)
                                             ^^^^
Smatch marks this as untrusted

   478                          return -EINVAL;
   479  
   480                  memset(b, 0, sizeof(b));
   481                  memcpy(b, ptr + 4, 8);
   482                  if (kstrtoul(b, 16, &addr) < 0)
   483                          return -EINVAL;
   484  
   485                  memset(b, 0, sizeof(b));
   486                  memcpy(b, ptr + (size * 2) + 2, 2);
                                  ^^^^^^^^^^^^^^^^^^^^
We could be copying from anywhere

   487                  if (kstrtoul(b, 16, &fcs) < 0)
   488                          return -EINVAL;
   489  
   490                  memset(b, 0, sizeof(b));
   491                  for (tmp = 0, i = 0; i < size; i++) {
   492                          memcpy(b, ptr + (i * 2) + 2, 2);
   493                          tmp += simple_strtol(b, NULL, 16);
   494                  }
   495  
   496                  if (((tmp + fcs) & 0xff) != 0xff) {
   497                          BT_ERR("Checksum error in firmware");
   498                          err = -EILSEQ;
   499                          goto error;
   500                  }
   501  
   502                  if (ptr[1] == '3') {
   503                          bt3c_address(iobase, addr);
   504  
   505                          memset(b, 0, sizeof(b));
   506                          for (i = 0; i < (size - 4) / 2; i++) {
   507                                  memcpy(b, ptr + (i * 4) + 12, 4);
   508                                  tmp = simple_strtoul(b, NULL, 16);
   509                                  bt3c_put(iobase, tmp);
   510                          }
   511                  }

regards,
dan carpenter
