Return-Path: <aklish1@urbana.css.mot.com>
Date: Wed, 22 Oct 2003 10:17:16 -0500 (CDT)
From: Aaron Klish <aklish1@urbana.css.mot.com>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Aaron Klish <AKLISH1@motorola.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM TTY data loss
In-Reply-To: <1066738150.1005.119.camel@pegasus>
Message-ID: <Pine.GSO.4.20.0310211432100.10220-200000@wombat.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-684387517-1066765639=:10220"
List-ID: <bluez-devel.lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-684387517-1066765639=:10220
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.20.0310221004521.1115@angel.urbana.css.mot.com>

Hi Marcel,
  I'm testing with Kernel 2.4.20.  I've tested this on machines patched with 

patch-2.4.20-mh12

as well as 

patch-2.4.20-mh9

Source for a sample program to reproduce the failure is attached.  Below are the steps I took
to reproduce the problem with this sample:

Machine A                                      Machine B
----------                                     ----------
                                               rfcomm listen 0 1
rfcomm connect 0 XX:XX:XX:XX:XX:XX 1
stress /dev/rfcomm0 0                     
                                               stress /dev/rfcomm0 1
                                               Machine B starts writing
wait until Machine B stops writing...
Press a key
Machine A starts reading....


If you redirect the output of stress from Machine A, you should see something like:

Note after 409 reads (actually exactly 4096 bytes), there is data loss:

Start 1066754940.343150 
Reader
Press Enter when the Writer stops sending...
Time: 30.004504 Read: ^^^     0
Time: 30.004533 Read: ^^^     1
Time: 30.004542 Read: ^^^     2
Time: 30.004551 Read: ^^^     3
Time: 30.004560 Read: ^^^     4
Time: 30.004568 Read: ^^^     5
Time: 30.004577 Read: ^^^     6
Time: 30.004586 Read: ^^^     7
Time: 30.004595 Read: ^^^     8
Time: 30.004603 Read: ^^^     9
Time: 30.004612 Read: ^^^    10
Time: 30.004621 Read: ^^^    11
Time: 30.004630 Read: ^^^    12
Time: 30.004639 Read: ^^^    13
Time: 30.004647 Read: ^^^    14
Time: 30.004656 Read: ^^^    15
Time: 30.004665 Read: ^^^    16
Time: 30.004674 Read: ^^^    17
Time: 30.004683 Read: ^^^    18
Time: 30.004691 Read: ^^^    19
Time: 30.004700 Read: ^^^    20
Time: 30.004709 Read: ^^^    21
Time: 30.004718 Read: ^^^    22
Time: 30.004727 Read: ^^^    23
Time: 30.004735 Read: ^^^    24
Time: 30.004744 Read: ^^^    25
Time: 30.004753 Read: ^^^    26
Time: 30.004762 Read: ^^^    27
Time: 30.004770 Read: ^^^    28
Time: 30.004779 Read: ^^^    29
Time: 30.004788 Read: ^^^    30
Time: 30.004797 Read: ^^^    31
Time: 30.004806 Read: ^^^    32
Time: 30.004814 Read: ^^^    33
Time: 30.004823 Read: ^^^    34
Time: 30.004832 Read: ^^^    35
Time: 30.004841 Read: ^^^    36
Time: 30.004849 Read: ^^^    37
Time: 30.004858 Read: ^^^    38
Time: 30.004867 Read: ^^^    39
Time: 30.004876 Read: ^^^    40
Time: 30.004885 Read: ^^^    41
Time: 30.004893 Read: ^^^    42
Time: 30.004902 Read: ^^^    43
Time: 30.004911 Read: ^^^    44
Time: 30.004920 Read: ^^^    45
Time: 30.004929 Read: ^^^    46
Time: 30.004937 Read: ^^^    47
Time: 30.004946 Read: ^^^    48
Time: 30.004955 Read: ^^^    49
Time: 30.004964 Read: ^^^    50
Time: 30.004972 Read: ^^^    51
Time: 30.004981 Read: ^^^    52
Time: 30.004990 Read: ^^^    53
Time: 30.004999 Read: ^^^    54
Time: 30.005008 Read: ^^^    55
Time: 30.005016 Read: ^^^    56
Time: 30.005025 Read: ^^^    57
Time: 30.005034 Read: ^^^    58
Time: 30.005043 Read: ^^^    59
Time: 30.005051 Read: ^^^    60
Time: 30.005060 Read: ^^^    61
Time: 30.005069 Read: ^^^    62
Time: 30.005077 Read: ^^^    63
Time: 30.005086 Read: ^^^    64
Time: 30.005095 Read: ^^^    65
Time: 30.005104 Read: ^^^    66
Time: 30.005112 Read: ^^^    67
Time: 30.005121 Read: ^^^    68
Time: 30.005130 Read: ^^^    69
Time: 30.005139 Read: ^^^    70
Time: 30.005147 Read: ^^^    71
Time: 30.005156 Read: ^^^    72
Time: 30.005165 Read: ^^^    73
Time: 30.005173 Read: ^^^    74
Time: 30.005182 Read: ^^^    75
Time: 30.005191 Read: ^^^    76
Time: 30.005200 Read: ^^^    77
Time: 30.005208 Read: ^^^    78
Time: 30.005217 Read: ^^^    79
Time: 30.005226 Read: ^^^    80
Time: 30.005235 Read: ^^^    81
Time: 30.005243 Read: ^^^    82
Time: 30.005252 Read: ^^^    83
Time: 30.005261 Read: ^^^    84
Time: 30.005270 Read: ^^^    85
Time: 30.005278 Read: ^^^    86
Time: 30.005287 Read: ^^^    87
Time: 30.005296 Read: ^^^    88
Time: 30.005305 Read: ^^^    89
Time: 30.005313 Read: ^^^    90
Time: 30.005322 Read: ^^^    91
Time: 30.005331 Read: ^^^    92
Time: 30.005340 Read: ^^^    93
Time: 30.005349 Read: ^^^    94
Time: 30.005357 Read: ^^^    95
Time: 30.005366 Read: ^^^    96
Time: 30.005375 Read: ^^^    97
Time: 30.005383 Read: ^^^    98
Time: 30.005392 Read: ^^^    99
Time: 30.005401 Read: ^^^   100
Time: 30.005410 Read: ^^^   101
Time: 30.005419 Read: ^^^   102
Time: 30.005427 Read: ^^^   103
Time: 30.005436 Read: ^^^   104
Time: 30.005445 Read: ^^^   105
Time: 30.005454 Read: ^^^   106
Time: 30.005462 Read: ^^^   107
Time: 30.005471 Read: ^^^   108
Time: 30.005480 Read: ^^^   109
Time: 30.005489 Read: ^^^   110
Time: 30.005497 Read: ^^^   111
Time: 30.005506 Read: ^^^   112
Time: 30.005515 Read: ^^^   113
Time: 30.005524 Read: ^^^   114
Time: 30.005532 Read: ^^^   115
Time: 30.005541 Read: ^^^   116
Time: 30.005550 Read: ^^^   117
Time: 30.005559 Read: ^^^   118
Time: 30.005567 Read: ^^^   119
Time: 30.005576 Read: ^^^   120
Time: 30.005585 Read: ^^^   121
Time: 30.005594 Read: ^^^   122
Time: 30.005602 Read: ^^^   123
Time: 30.005611 Read: ^^^   124
Time: 30.005620 Read: ^^^   125
Time: 30.005635 Read: ^^^   126
Time: 30.005644 Read: ^^^   127
Time: 30.005653 Read: ^^^   128
Time: 30.005662 Read: ^^^   129
Time: 30.005670 Read: ^^^   130
Time: 30.005679 Read: ^^^   131
Time: 30.005688 Read: ^^^   132
Time: 30.005697 Read: ^^^   133
Time: 30.005705 Read: ^^^   134
Time: 30.005714 Read: ^^^   135
Time: 30.005723 Read: ^^^   136
Time: 30.005732 Read: ^^^   137
Time: 30.005740 Read: ^^^   138
Time: 30.005749 Read: ^^^   139
Time: 30.005758 Read: ^^^   140
Time: 30.005767 Read: ^^^   141
Time: 30.005775 Read: ^^^   142
Time: 30.005784 Read: ^^^   143
Time: 30.005793 Read: ^^^   144
Time: 30.005801 Read: ^^^   145
Time: 30.005810 Read: ^^^   146
Time: 30.005819 Read: ^^^   147
Time: 30.005827 Read: ^^^   148
Time: 30.005836 Read: ^^^   149
Time: 30.005845 Read: ^^^   150
Time: 30.005854 Read: ^^^   151
Time: 30.005862 Read: ^^^   152
Time: 30.005871 Read: ^^^   153
Time: 30.005880 Read: ^^^   154
Time: 30.005889 Read: ^^^   155
Time: 30.005897 Read: ^^^   156
Time: 30.005906 Read: ^^^   157
Time: 30.005915 Read: ^^^   158
Time: 30.005924 Read: ^^^   159
Time: 30.005932 Read: ^^^   160
Time: 30.005941 Read: ^^^   161
Time: 30.005950 Read: ^^^   162
Time: 30.005959 Read: ^^^   163
Time: 30.005967 Read: ^^^   164
Time: 30.005976 Read: ^^^   165
Time: 30.005985 Read: ^^^   166
Time: 30.005993 Read: ^^^   167
Time: 30.006002 Read: ^^^   168
Time: 30.006011 Read: ^^^   169
Time: 30.006020 Read: ^^^   170
Time: 30.006028 Read: ^^^   171
Time: 30.006037 Read: ^^^   172
Time: 30.006046 Read: ^^^   173
Time: 30.006055 Read: ^^^   174
Time: 30.006063 Read: ^^^   175
Time: 30.006072 Read: ^^^   176
Time: 30.006081 Read: ^^^   177
Time: 30.006089 Read: ^^^   178
Time: 30.006098 Read: ^^^   179
Time: 30.006107 Read: ^^^   180
Time: 30.006116 Read: ^^^   181
Time: 30.006124 Read: ^^^   182
Time: 30.006133 Read: ^^^   183
Time: 30.006142 Read: ^^^   184
Time: 30.006150 Read: ^^^   185
Time: 30.006159 Read: ^^^   186
Time: 30.006168 Read: ^^^   187
Time: 30.006176 Read: ^^^   188
Time: 30.006185 Read: ^^^   189
Time: 30.006194 Read: ^^^   190
Time: 30.006203 Read: ^^^   191
Time: 30.006211 Read: ^^^   192
Time: 30.006220 Read: ^^^   193
Time: 30.006229 Read: ^^^   194
Time: 30.006238 Read: ^^^   195
Time: 30.006246 Read: ^^^   196
Time: 30.006255 Read: ^^^   197
Time: 30.006264 Read: ^^^   198
Time: 30.006272 Read: ^^^   199
Time: 30.006281 Read: ^^^   200
Time: 30.006290 Read: ^^^   201
Time: 30.006299 Read: ^^^   202
Time: 30.006307 Read: ^^^   203
Time: 30.006316 Read: ^^^   204
Time: 30.006325 Read: ^^^   205
Time: 30.006334 Read: ^^^   206
Time: 30.006342 Read: ^^^   207
Time: 30.006351 Read: ^^^   208
Time: 30.006360 Read: ^^^   209
Time: 30.006369 Read: ^^^   210
Time: 30.006377 Read: ^^^   211
Time: 30.006386 Read: ^^^   212
Time: 30.006395 Read: ^^^   213
Time: 30.006404 Read: ^^^   214
Time: 30.006412 Read: ^^^   215
Time: 30.006421 Read: ^^^   216
Time: 30.006430 Read: ^^^   217
Time: 30.006438 Read: ^^^   218
Time: 30.006447 Read: ^^^   219
Time: 30.006456 Read: ^^^   220
Time: 30.006465 Read: ^^^   221
Time: 30.006473 Read: ^^^   222
Time: 30.006482 Read: ^^^   223
Time: 30.006491 Read: ^^^   224
Time: 30.006499 Read: ^^^   225
Time: 30.006508 Read: ^^^   226
Time: 30.006517 Read: ^^^   227
Time: 30.006526 Read: ^^^   228
Time: 30.006534 Read: ^^^   229
Time: 30.006543 Read: ^^^   230
Time: 30.006552 Read: ^^^   231
Time: 30.006560 Read: ^^^   232
Time: 30.006569 Read: ^^^   233
Time: 30.006578 Read: ^^^   234
Time: 30.006587 Read: ^^^   235
Time: 30.006595 Read: ^^^   236
Time: 30.006604 Read: ^^^   237
Time: 30.006613 Read: ^^^   238
Time: 30.006621 Read: ^^^   239
Time: 30.006630 Read: ^^^   240
Time: 30.006639 Read: ^^^   241
Time: 30.006648 Read: ^^^   242
Time: 30.006657 Read: ^^^   243
Time: 30.006665 Read: ^^^   244
Time: 30.006674 Read: ^^^   245
Time: 30.006683 Read: ^^^   246
Time: 30.006691 Read: ^^^   247
Time: 30.006700 Read: ^^^   248
Time: 30.006709 Read: ^^^   249
Time: 30.006718 Read: ^^^   250
Time: 30.006726 Read: ^^^   251
Time: 30.006735 Read: ^^^   252
Time: 30.006744 Read: ^^^   253
Time: 30.006758 Read: ^^^   254
Time: 30.006767 Read: ^^^   255
Time: 30.006775 Read: ^^^   256
Time: 30.006784 Read: ^^^   257
Time: 30.006793 Read: ^^^   258
Time: 30.006802 Read: ^^^   259
Time: 30.006810 Read: ^^^   260
Time: 30.006819 Read: ^^^   261
Time: 30.006828 Read: ^^^   262
Time: 30.006837 Read: ^^^   263
Time: 30.006845 Read: ^^^   264
Time: 30.006854 Read: ^^^   265
Time: 30.006863 Read: ^^^   266
Time: 30.006872 Read: ^^^   267
Time: 30.006881 Read: ^^^   268
Time: 30.006889 Read: ^^^   269
Time: 30.006898 Read: ^^^   270
Time: 30.006907 Read: ^^^   271
Time: 30.006916 Read: ^^^   272
Time: 30.006924 Read: ^^^   273
Time: 30.006933 Read: ^^^   274
Time: 30.006942 Read: ^^^   275
Time: 30.006951 Read: ^^^   276
Time: 30.006959 Read: ^^^   277
Time: 30.006968 Read: ^^^   278
Time: 30.006977 Read: ^^^   279
Time: 30.006986 Read: ^^^   280
Time: 30.006995 Read: ^^^   281
Time: 30.007003 Read: ^^^   282
Time: 30.007012 Read: ^^^   283
Time: 30.007021 Read: ^^^   284
Time: 30.007030 Read: ^^^   285
Time: 30.007038 Read: ^^^   286
Time: 30.007047 Read: ^^^   287
Time: 30.007056 Read: ^^^   288
Time: 30.007065 Read: ^^^   289
Time: 30.007073 Read: ^^^   290
Time: 30.007082 Read: ^^^   291
Time: 30.007091 Read: ^^^   292
Time: 30.007100 Read: ^^^   293
Time: 30.007109 Read: ^^^   294
Time: 30.007117 Read: ^^^   295
Time: 30.007126 Read: ^^^   296
Time: 30.007135 Read: ^^^   297
Time: 30.007143 Read: ^^^   298
Time: 30.007152 Read: ^^^   299
Time: 30.007161 Read: ^^^   300
Time: 30.007170 Read: ^^^   301
Time: 30.007178 Read: ^^^   302
Time: 30.007187 Read: ^^^   303
Time: 30.007196 Read: ^^^   304
Time: 30.007205 Read: ^^^   305
Time: 30.007214 Read: ^^^   306
Time: 30.007222 Read: ^^^   307
Time: 30.007231 Read: ^^^   308
Time: 30.007240 Read: ^^^   309
Time: 30.007249 Read: ^^^   310
Time: 30.007258 Read: ^^^   311
Time: 30.007266 Read: ^^^   312
Time: 30.007275 Read: ^^^   313
Time: 30.007284 Read: ^^^   314
Time: 30.007293 Read: ^^^   315
Time: 30.007301 Read: ^^^   316
Time: 30.007310 Read: ^^^   317
Time: 30.007319 Read: ^^^   318
Time: 30.007328 Read: ^^^   319
Time: 30.007337 Read: ^^^   320
Time: 30.007345 Read: ^^^   321
Time: 30.007354 Read: ^^^   322
Time: 30.007363 Read: ^^^   323
Time: 30.007372 Read: ^^^   324
Time: 30.007380 Read: ^^^   325
Time: 30.007389 Read: ^^^   326
Time: 30.007398 Read: ^^^   327
Time: 30.007407 Read: ^^^   328
Time: 30.007416 Read: ^^^   329
Time: 30.007424 Read: ^^^   330
Time: 30.007433 Read: ^^^   331
Time: 30.007442 Read: ^^^   332
Time: 30.007451 Read: ^^^   333
Time: 30.007459 Read: ^^^   334
Time: 30.007468 Read: ^^^   335
Time: 30.007477 Read: ^^^   336
Time: 30.007486 Read: ^^^   337
Time: 30.007494 Read: ^^^   338
Time: 30.007503 Read: ^^^   339
Time: 30.007512 Read: ^^^   340
Time: 30.007521 Read: ^^^   341
Time: 30.007530 Read: ^^^   342
Time: 30.007538 Read: ^^^   343
Time: 30.007547 Read: ^^^   344
Time: 30.007556 Read: ^^^   345
Time: 30.007565 Read: ^^^   346
Time: 30.007574 Read: ^^^   347
Time: 30.007582 Read: ^^^   348
Time: 30.007591 Read: ^^^   349
Time: 30.007600 Read: ^^^   350
Time: 30.007609 Read: ^^^   351
Time: 30.007618 Read: ^^^   352
Time: 30.007626 Read: ^^^   353
Time: 30.007635 Read: ^^^   354
Time: 30.007644 Read: ^^^   355
Time: 30.007653 Read: ^^^   356
Time: 30.007661 Read: ^^^   357
Time: 30.007670 Read: ^^^   358
Time: 30.007679 Read: ^^^   359
Time: 30.007688 Read: ^^^   360
Time: 30.007696 Read: ^^^   361
Time: 30.007705 Read: ^^^   362
Time: 30.007714 Read: ^^^   363
Time: 30.007723 Read: ^^^   364
Time: 30.007731 Read: ^^^   365
Time: 30.007740 Read: ^^^   366
Time: 30.007749 Read: ^^^   367
Time: 30.007758 Read: ^^^   368
Time: 30.007766 Read: ^^^   369
Time: 30.007775 Read: ^^^   370
Time: 30.007784 Read: ^^^   371
Time: 30.007793 Read: ^^^   372
Time: 30.007801 Read: ^^^   373
Time: 30.007810 Read: ^^^   374
Time: 30.007819 Read: ^^^   375
Time: 30.007828 Read: ^^^   376
Time: 30.007837 Read: ^^^   377
Time: 30.007845 Read: ^^^   378
Time: 30.007854 Read: ^^^   379
Time: 30.007863 Read: ^^^   380
Time: 30.007872 Read: ^^^   381
Time: 30.007886 Read: ^^^   382
Time: 30.007894 Read: ^^^   383
Time: 30.007903 Read: ^^^   384
Time: 30.007912 Read: ^^^   385
Time: 30.007921 Read: ^^^   386
Time: 30.007929 Read: ^^^   387
Time: 30.007938 Read: ^^^   388
Time: 30.007947 Read: ^^^   389
Time: 30.007956 Read: ^^^   390
Time: 30.007965 Read: ^^^   391
Time: 30.007973 Read: ^^^   392
Time: 30.007982 Read: ^^^   393
Time: 30.007991 Read: ^^^   394
Time: 30.008000 Read: ^^^   395
Time: 30.008011 Read: ^^^   396
Time: 30.008020 Read: ^^^   397
Time: 30.008028 Read: ^^^   398
Time: 30.008037 Read: ^^^   399
Time: 30.008046 Read: ^^^   400
Time: 30.008055 Read: ^^^   401
Time: 30.008063 Read: ^^^   402
Time: 30.008072 Read: ^^^   403
Time: 30.008081 Read: ^^^   404
Time: 30.008090 Read: ^^^   405
Time: 30.008099 Read: ^^^   406
Time: 30.008107 Read: ^^^   407
Time: 30.008116 Read: ^^^   408
Time: 30.084010 Read: ^^^   ^^^ Time: 30.135041 Read:   430
^^^ Time: 30.184230 Read:   431
^^^ Time: 30.235278 Read:   432
^^^ Time: 30.284599 Read:   433
^^^ Time: 30.333983 Read:   434
^^^ Time: 30.384363 Read:   435
^^^ Time: 30.435298 Read:   436
^^^ Time: 30.484711 Read:   437
^^^ Time: 30.534109 Read:   438
^^^ Time: 30.589305 Read:   439
^^^ Time: 30.615675 Read:   440
^^^ Time: 30.642327 Read:   441
^^^ Time: 30.684037 Read:   442
^^^ Time: 30.714305 Read:   443
^^^ Time: 30.765267 Read:   444
^^^ Time: 30.814674 Read:   445
^^^ Time: 30.864064 Read:   446
^^^ Time: 30.914816 Read:   447
^^^ Time: 30.964289 Read:   448
^^^ Time: 31.015247 Read:   449
^^^ Time: 31.064673 Read:   450
^^^ Time: 31.114057 Read:   451
^^^ Time: 31.164798 Read:   452
^^^ Time: 31.214284 Read:   453
^^^ Time: 31.265191 Read:   454
^^^ Time: 31.314663 Read:   455
^^^ Time: 31.363993 Read:   456
^^^ Time: 31.414790 Read:   457
^^^ Time: 31.464310 Read:   458
^^^ Time: 31.470468 Read:   459
^^^ Time: 31.473694 Read:   460
^^^ Time: 31.475777 Read:   461
^^^ Time: 31.477862 Read:   462
^^^ Time: 31.481375 Read:   463
^^^ Time: 31.483453 Read:   464
^^^ Time: 31.485613 Read:   465
^^^ Time: 31.514381 Read:   466
^^^ Time: 31.565271 Read:   467
^^^ Time: 31.614643 Read:   468
^^^ Time: 31.664817 Read:   469
^^^ Time: 31.714192 Read:   470
^^^ Time: 31.765191 Read:   471
^^^ Time: 31.814432 Read:   472
^^^ Time: 31.924076 Read:   473
^^^ Time: 31.964394 Read:   474
^^^ Time: 31.993514 Read:   475
^^^ Time: 32.042905 Read:   476
^^^ Time: 32.093809 Read:   477
^^^ Time: 32.143131 Read:   478
^^^ Time: 32.194076 Read:   479
^^^ Time: 32.243517 Read:   480
^^^ Time: 32.292888 Read:   481
^^^ Time: 32.343639 Read:   482
^^^ Time: 32.393122 Read:   483
^^^ Time: 32.444019 Read:   484
^^^ Time: 32.493498 Read:   485
^^^ Time: 32.542838 Read:   486
^^^ Time: 32.593623 Read:   487
^^^ Time: 32.643174 Read:   488
^^^ Time: 32.649367 Read:   489
^^^ Time: 32.652549 Read:   490
^^^ Time: 32.654639 Read:   491
^^^ Time: 32.656714 Read:   492
^^^ Time: 32.660239 Read:   493
^^^ Time: 32.662490 Read:   494
^^^ Time: 32.692864 Read:   495
^^^ Time: 32.743616 Read:   496
^^^ Time: 32.793011 Read:   497
^^^ Time: 32.844018 Read:   498
^^^ Time: 32.893235 Read:   499
^^^ Time: 32.942872 Read:   500
^^^ Time: 32.993652 Read:   501
^^^ Time: 33.043009 Read:   502
^^^ Time: 33.094041 Read:   503
^^^ Time: 33.201508 Read:   504
^^^ Time: 33.243234 Read:   505
^^^ Time: 33.274922 Read:   506
^^^ Time: 33.324263 Read:   507
^^^ Time: 33.375316 Read:   508
^^^ Time: 33.400248 Read:   509
^^^ Time: 33.449788 Read:   510
^^^ Time: 33.499225 Read:   511
^^^ Time: 33.550179 Read:   512
^^^ Time: 33.599363 Read:   513
^^^ Time: 33.626009 Read:   514
^^^ Time: 33.674142 Read:   515
^^^ Time: 33.724876 Read:   516
^^^ Time: 33.774412 Read:   517
^^^ Time: 33.825365 Read:   518
^^^ Time: 33.832629 Read:   519
^^^ Time: 33.834710 Read:   520
^^^ Time: 33.836871 Read:   521
^^^ Time: 33.839630 Read:   522
^^^ Time: 33.850565 Read:   523
^^^ Time: 33.900251 Read:   524
^^^ Time: 33.949443 Read:   525
^^^ Time: 33.999066 Read:   526
^^^ Time: 34.049795 Read:   527
^^^ Time: 34.099210 Read:   528
^^^ Time: 34.125657 Read:   529
^^^ Time: 34.175358 Read:   530
^^^ Time: 34.224719 Read:   531
^^^ Time: 34.274209 Read:   532
^^^ Time: 34.325010 Read:   533
^^^ Time: 34.351615 Read:   534
^^^ Time: 34.410390 Read:   535
^^^ Time: 34.449502 Read:   536
^^^ Time: 34.476055 Read:   537
^^^ Time: 34.524186 Read:   538
^^^ Time: 34.554473 Read:   539
^^^ Time: 34.581082 Read:   540
^^^ Time: 34.629211 Read:   541
^^^ Time: 34.679949 Read:   542
^^^ Time: 34.729444 Read:   543
^^^ Time: 34.780336 Read:   544
^^^ Time: 34.805343 Read:   545
^^^ Time: 34.854973 Read:   546
^^^ Time: 34.904308 Read:   547
^^^ Time: 34.955359 Read:   548
^^^ Time: 34.962571 Read:   549
^^^ Time: 34.964652 Read:   550
^^^ Time: 34.966809 Read:   551
^^^ Time: 34.969567 Read:   552
^^^ Time: 34.972505 Read:   553
^^^ Time: 35.004221 Read:   554
^^^ Time: 35.029382 Read:   555
^^^ Time: 35.054395 Read:   556
^^^ Time: 35.080805 Read:   557
^^^ Time: 35.130553 Read:   558
^^^ Time: 35.179915 Read:   559
^^^ Time: 35.229266 Read:   560
^^^ Time: 35.280301 Read:   561
^^^ Time: 35.305414 Read:   562
^^^ Time: 35.330399 Read:   563
^^^ Time: 35.355400 Read:   564
^^^ Time: 35.405020 Read:   565
^^^ Time: 35.454370 Read:   566
^^^ Time: 35.505368 Read:   567
^^^ Time: 35.554783 Read:   568
^^^ Time: 35.579940 Read:   569
^^^ Time: 35.604936 Read:   570
^^^ Time: 35.631443 Read:   571
^^^ Time: 35.689209 Read:   572
^^^ Time: 35.729597 Read:   573
^^^ Time: 35.754871 Read:   574
^^^ Time: 35.804268 Read:   575
^^^ Time: 35.834555 Read:   576
^^^ Time: 35.884153 Read:   577
^^^ Time: 35.909381 Read:   578
^^^ Time: 35.915541 Read:   579
^^^ Time: 35.918724 Read:   580
^^^ Time: 35.920971 Read:   581
^^^ Time: 35.923871 Read:   582
^^^ Time: 35.926649 Read:   583
^^^ Time: 35.928726 Read:   584
^^^ Time: 35.930793 Read:   585
^^^ Time: 35.961122 Read:   586
^^^ Time: 36.009278 Read:   587
^^^ Time: 36.060012 Read:   588
^^^ Time: 36.109492 Read:   589
^^^ Time: 36.160453 Read:   590
^^^ Time: 36.209865 Read:   591
^^^ Time: 36.235007 Read:   592
^^^ Time: 36.260033 Read:   593
^^^ Time: 36.286516 Read:   594
^^^ Time: 36.334496 Read:   595
^^^ Time: 36.385493 Read:   596
^^^ Time: 36.434873 Read:   597
^^^ Time: 36.484314 Read:   598
^^^ Time: 36.509463 Read:   599
^^^ Time: 36.534466 Read:   600
^^^ Time: 36.560876 Read:   601
^^^ Time: 36.610621 Read:   602
^^^ Time: 36.659278 Read:   603
^^^ Time: 36.710034 Read:   604
^^^ Time: 36.759511 Read:   605
^^^ Time: 36.786704 Read:   606
^^^ Time: 36.834624 Read:   607
^^^ Time: 36.884273 Read:   608
^^^ Time: 36.890510 Read:   609
^^^ Time: 36.893540 Read:   610
^^^ Time: 36.895777 Read:   611
^^^ Time: 36.898834 Read:   612
^^^ Time: 36.901606 Read:   613
^^^ Time: 36.903686 Read:   614
^^^ Time: 36.905753 Read:   615
^^^ Time: 36.934409 Read:   616
^^^ Time: 37.045470 Read:   617
^^^ Time: 37.084630 Read:   618
^^^ Time: 37.115086 Read:   619
^^^ Time: 37.164440 Read:   620
^^^ Time: 37.215341 Read:   621
^^^ Time: 37.264638 Read:   622
^^^ Time: 37.291175 Read:   623
^^^ Time: 37.339312 Read:   624
^^^ Time: 37.390312 Read:   625
^^^ Time: 37.439567 Read:   626
^^^ Time: 37.490544 Read:   627
^^^ Time: 37.539910 Read:   628
^^^ Time: 37.566275 Read:   629
^^^ Time: 37.614408 Read:   630
^^^ Time: 37.665407 Read:   631
^^^ Time: 37.714628 Read:   632
^^^ Time: 37.764272 Read:   633
^^^ Time: 37.815018 Read:   634
^^^ Time: 37.841573 Read:   635
^^^ Time: 37.889604 Read:   636
^^^ Time: 37.940547 Read:   637
^^^ Time: 37.989965 Read:   638
^^^ Time: 37.995990 Read:   639
^^^ Time: 37.998234 Read:   640
^^^ Time: 38.001292 Read:   641
^^^ Time: 38.003371 Read:   642
^^^ Time: 38.007110 Read:   643
^^^ Time: 38.009356 Read:   644
^^^ Time: 38.039624 Read:   645
^^^ Time: 38.090568 Read:   646
^^^ Time: 38.115563 Read:   647
^^^ Time: 38.165360 Read:   648
^^^ Time: 38.214540 Read:   649
^^^ Time: 38.328056 Read:   650
^^^ Time: 38.364708 Read:   651
^^^ Time: 38.395290 Read:   652
^^^ Time: 38.420131 Read:   653
^^^ Time: 38.446659 Read:   654
^^^ Time: 38.494658 Read:   655
^^^ Time: 38.544216 Read:   656
^^^ Time: 38.595010 Read:   657
^^^ Time: 38.644446 Read:   658
^^^ Time: 38.670849 Read:   659
^^^ Time: 38.720560 Read:   660
^^^ Time: 38.769966 Read:   661
^^^ Time: 38.819361 Read:   662
^^^ Time: 38.870105 Read:   663
^^^ Time: 38.919585 Read:   664
^^^ Time: 38.946147 Read:   665
^^^ Time: 38.994236 Read:   666
^^^ Time: 39.045115 Read:   667
^^^ Time: 39.094538 Read:   668
^^^ Time: 39.100793 Read:   669
^^^ Time: 39.103996 Read:   670
^^^ Time: 39.106098 Read:   671
^^^ Time: 39.108196 Read:   672
^^^ Time: 39.111705 Read:   673
^^^ Time: 39.113953 Read:   674
^^^ Time: 39.144357 Read:   675
^^^ Time: 39.195098 Read:   676
^^^ Time: 39.221663 Read:   677
^^^ Time: 39.269711 Read:   678
^^^ Time: 39.320658 Read:   679
^^^ Time: 39.369497 Read:   680
^^^ Time: 39.420538 Read:   681
^^^ Time: 39.469766 Read:   682
^^^ Time: 39.496283 Read:   683
^^^ Time: 39.556264 Read:   684
^^^ Time: 39.646041 Read:   685
^^^ Time: 39.676605 Read:   686
^^^ Time: 39.701604 Read:   687
^^^ 


------------
Aaron Klish
Bluetooth Software Engineer
Motorola PCS
PH# (217) 384-8598
FX# (217) 384-8550

[X]  Motorola General Business Information
[ ]  Motorola Internal Use Only
[ ]  Motorola Confidential Proprietary

On 21 Oct 2003, Marcel Holtmann wrote:

> Hi Aaron,
> 
> > There seems to be a problem between the Rfcomm tty driver code 
> > and the generic n_tty line discipline where data can be lost.  
> 
> please tell us which kernel version you have tested. Have you used any
> additional patches that we should know of? We included a TTY buffer
> management patch from David Woodhouse some time ago.
> 
> Do you have a test program with that we can reproduce this behaviour?
> 
> Regards
> 
> Marcel
> 
> 

---559023410-684387517-1066765639=:10220
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="stress3.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.20.0310221017160.1115@angel.urbana.css.mot.com>
Content-Description: 
Content-Disposition: attachment; filename="stress3.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c2lnbmFsLmg+DQojaW5j
bHVkZSA8ZmNudGwuaD4gDQojaW5jbHVkZSA8dGVybWlvcy5oPg0KDQpkb3Vi
bGUgdGltZXN0YW1wKCk7DQoNCmNoYXIgcmJ1ZmZbMTAyNF07DQoNCmRvdWJs
ZSBpbml0Ow0KDQppbnQgb3Blbl9wb3J0IChjaGFyICp0dHkpDQp7DQogICAg
aW50IGZkOw0KICAgIHN0cnVjdCB0ZXJtaW9zIHRpbzsNCiAgICBzdGF0aWMg
Y2hhciB0ZW1wWzEwMjRdOw0KICAgIGlmICgoZmQgPSBvcGVuKHR0eSwgT19S
RFdSIHwgT19OT0NUVFkgKSkgPCAwKQ0KICAgIHsNCiAgICAgICAgZnByaW50
ZihzdGRlcnIsICJFcnJvciBvcGVuaW5nICVzOiAiLCB0dHkpOw0KICAgICAg
ICBwZXJyb3IoTlVMTCk7DQogICAgICAgIGV4aXQoLTEpOw0KICAgIH0NCg0K
ICAgIA0KICAgIHRjZ2V0YXR0cihmZCwgJnRpbyk7DQogICAgdGlvLmNfY2Zs
YWcgPSBCOTYwMCB8IENTOCB8ICBDUkVBRCB8IENMT0NBTDsNCiAgICB0aW8u
Y19pZmxhZyA9IDA7DQogICAgdGlvLmNfb2ZsYWcgPSAwOw0KICAgIHRpby5j
X2xmbGFnID0gMDsNCiAgICB0aW8uY19jY1tWTUlOXSA9IDE7DQogICAgdGlv
LmNfY2NbVlRJTUVdID0gMDsNCiAgICBjZnNldG9zcGVlZCgmdGlvLCBCOTYw
MCk7DQogICAgY2ZzZXRpc3BlZWQoJnRpbywgQjk2MDApOw0KICAgIHRjZmx1
c2goZmQsIFRDSU9GTFVTSCk7DQogICAgdGNzZXRhdHRyKGZkLCBUQ1NBTk9X
LCAmdGlvKTsNCg0KICAgIA0KICAgIHJldHVybiBmZDsNCn0NCg0Kdm9pZCB3
cml0ZV9uKGludCBmZCwgY2hhciAqYnVmZiwgaW50IHNpemUpew0KICBpbnQg
Y291bnQgPSAwLCB0aGlzVGltZTsNCg0KICB3aGlsZShjb3VudCA8IHNpemUp
ew0KDQogICAgdGhpc1RpbWUgPSB3cml0ZShmZCwgYnVmZiArIGNvdW50LCBz
aXplIC0gY291bnQpOw0KICAgIGlmKHRoaXNUaW1lID4gMCkNCiAgICAgIGNv
dW50ICs9IHRoaXNUaW1lOw0KICAgIGVsc2V7DQogICAgICBwcmludGYoIiVk
XG4iLCBzaXplKTsNCiAgICAgIHBlcnJvcigiQ291bGQgbm90IGRvIGlvXG4i
KTsNCiAgICAgIGV4aXQoLTIpOw0KICAgIH0NCiAgfQ0KICBwcmludGYoIlRp
bWU6ICVmIFdyaXR0ZW46ICVzIiwgdGltZXN0YW1wKCktaW5pdCxidWZmKTsg
DQp9DQoNCg0Kdm9pZCByZWFkX24oaW50IGZkLCBjaGFyICpidWZmLCBpbnQg
c2l6ZSl7DQogIGludCBjb3VudCA9IDAsIHRoaXNUaW1lOw0KDQogIHdoaWxl
KGNvdW50IDwgc2l6ZSl7DQoNCiAgICB0aGlzVGltZSA9IHJlYWQoZmQsIGJ1
ZmYgKyBjb3VudCwgc2l6ZSAtIGNvdW50KTsNCiAgICBpZih0aGlzVGltZSA+
IDApDQogICAgICBjb3VudCArPSB0aGlzVGltZTsNCiAgICBlbHNlew0KICAg
ICAgcHJpbnRmKCIlZFxuIiwgc2l6ZSk7DQogICAgICBwZXJyb3IoIkNvdWxk
IG5vdCBkbyBpb1xuIik7DQogICAgICBleGl0KC0yKTsNCiAgICB9DQogIH0N
CiAgcHJpbnRmKCJUaW1lOiAlZiBSZWFkOiAlcyIsIHRpbWVzdGFtcCgpLWlu
aXQgLGJ1ZmYpOw0KfQ0KDQoNCnZvaWQgY29udHJvbGMoKXsNCiAgZG91Ymxl
IGZpbmFsID0gdGltZXN0YW1wKCk7DQogIGV4aXQoMCk7DQp9DQoNCm1haW4o
YXJnYywgYXJndikNCmludCBhcmdjOyBjaGFyICoqYXJndjsNCnsNCiAgaW50
IGZkMSwgZmQyLCBpPTA7DQogIGNoYXIgYzsNCiAgdW5zaWduZWQgd3JpdGVy
Ow0KICB2b2lkICgqIHJ3X2Z1bmMpIChpbnQsY2hhciosaW50KTsNCg0KICBp
ZihhcmdjIDwgMyl7DQogICAgcHJpbnRmKCJVc2FnZSAlcyA8ZGV2PiA8cmVh
ZGVyPTAgT1Igd3JpdGVyPTE+XG4iLCBhcmd2WzBdKTsNCiAgICBleGl0KC0x
KTsNCiAgfQ0KICANCiAgc2lnbmFsKFNJR0lOVCwgY29udHJvbGMpOw0KICAN
CiAgZmQxID0gZmQyID0gb3Blbl9wb3J0KGFyZ3ZbMV0pOw0KDQogIHNzY2Fu
Zihhcmd2WzJdLCAiJWQiLCAmd3JpdGVyKTsNCg0KICByd19mdW5jID0gKHdy
aXRlciA/IHdyaXRlX24gOiByZWFkX24pOw0KICBwcmludGYoIlN0YXJ0ICVm
IFxuIiwgaW5pdCA9IHRpbWVzdGFtcCgpKTsNCg0KICBpZiAod3JpdGVyKSB7
DQogICAgcHJpbnRmKCJXcml0ZXJcbiIpOw0KICB9IGVsc2Ugew0KICAgIHBy
aW50ZigiUmVhZGVyXG4gUHJlc3MgRW50ZXIgd2hlbiB0aGUgV3JpdGVyIHN0
b3BzIHNlbmRpbmcuLi5cbiIpOw0KICAgIHNjYW5mKCIlYyIsJmMpOw0KICB9
DQoNCiAgd2hpbGUoMSl7DQogICAgc3ByaW50ZihyYnVmZiwgIl5eXiU2ZFxu
IiwgaSk7IA0KICAgIHJ3X2Z1bmMoZmQxLCByYnVmZiwgMTApOw0KICAgIGkr
KzsNCiAgfQ0KfQ0KDQpkb3VibGUgdGltZXN0YW1wKCkNCnsNCiBzdHJ1Y3Qg
dGltZXZhbCB0cDsNCiBnZXR0aW1lb2ZkYXkoJnRwLCBOVUxMKTsNCiB0cC50
dl9zZWMgJj0gMHhGRkZGRkZGRjsNCiByZXR1cm4gKGRvdWJsZSl0cC50dl9z
ZWMgKyAoKChkb3VibGUpdHAudHZfdXNlYykvMTAwMDAwMCk7DQp9DQoNCg==
---559023410-684387517-1066765639=:10220--
