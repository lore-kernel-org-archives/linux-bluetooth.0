Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-Id: <200301101640.13586.wim.delvaux@adaptiveplanet.com>
Subject: [Bluez-users] better return code handling in rfcomm command
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 10 Jan 2003 16:40:13 +0100
Content-Type: multipart/mixed; boundary="=-LfVyLD+vC1iAsXm+1qNz"


--=-LfVyLD+vC1iAsXm+1qNz
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; CHARSET=us-ascii

Hi all,

just found out that some errors do not cause rfcomm to retrun with exit != 0
It seems that the 'func' field in the command jump table should return int and 
not void.

All commands can then return an error code (probably one that was generate by 
an deeper function) and cause exit to return proper return values.

Patch attached

--=-LfVyLD+vC1iAsXm+1qNz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch.gz"
Content-Type: application/x-gzip; NAME=patch.gz

H4sICCvpHj4AA3BhdGNoAK1WbU/jRhD+nPyKEVKpjW2wHV5CUnTkSLirCuTEpVVPVxQZew2rc2xu
veF6vfLfO7O7zgsESCGRol17vTPPPM/M7HqeByKNi9FoaxTxfDOuhb4fekHg+QGEfivcb4W7m371
A8cPfL/uOI7Z5eXs28zOBm7zAh+C3VZjv+U3H+w8PAQvbOy5e+Do4fCwDjXB5Fjk4LfrcFeHulfK
SPIYbgueQDxKhnGR5yyWFs8lxDJzgSYJu3XhMomSRAwlbOiZXorEVexCfB0J2NjAh1u77hibysRq
TMIPhF5KMY4llEX8RW0TMWR6l6ChPf1EEzZEH0PBvgL+25qOnYaiQw2KDp6CRf7gFwht5UW9MgYE
ixT8lF9Vr/TTMOUZs3GTbzbVbpgQhbDWjqL8ZwnFDcvh/Piof3oKegfQjjW7XffwYy1Cu+5M5uAF
hL9GmuCgAtoU8TCNRjz7DgfQOR6+Pfm9N+j3B+9NMLuhCkYNFEwF/jKKRzfWOka9mZTShbfdTrd7
PuycfbLh4GAKOb0RSHdqlTJB8C4Y7CnPE4gq2CyX4jukhTCk/pT8la+5JN8ysdRq+L8DlpUMnSrU
e3tuuIuw9WhwE2yr/IJxkrpMWrPhuvCxf/Tb8OPgvNc5xXAGH877g/5Q02vPqjAvQozySVbJoA0b
BWZAz2G+m6C5RBYQkQvWvbSDDXvdpF3J/2FFaqmnJ3CQqYco8LM4K0qGTpbFVBXSY7DEHCzxDCxj
7dXIogxz/WCejLZBfMUk2c2jEXuOzHWy8zhatDSPFMjoArhw7zcBv3hhLpQRG5WYfFQ6LvhTJtlX
29ZF1wh8Kjo9TDqIheWAFPAC25uKUyM9woQd9Lq9PzA6ZWPJVB0MPr1AhzI39YxgiBsXTjt/fugM
3p/0zsCDAAt8C5e2qjqeVLGOq6njalZxLW3vMhszWRTy2ljemjFtOpKVJkgPNcWpMSzgbv/s5BP8
i9Oz/hEGbS/ZUdEGj5drpoobFeBO4IY7GCGNoQ7RxLfW5aUpBkbdjXDjquY+TWwy/eyxqQRc6an5
aovIo6fox6KjE4HefvYvULcoy9bMWUAUaldDfGuhK0UrdeyZJXRsKRQKgV+BcI1b5W+Gpic9wpvZ
WrznG1rwv1wuVkOwjEXlSuVYgcml9TC+FgpSrd2j54Xs3/eE9D/uYDHX5XXxbZVEv9ae6h7Pskwd
mKpf3REzXkodq1+1Q7ydBNQP97bdoFk1xAeXS56nBSQce9sP4EkLIlnwyqENd5P+pw8G5UG3sHe9
AR4Lv54d9/FoSPjCvvcOzzjlII3w6phU7Y79zaUV2E9cHqeB0XaL7OtT4kEbAxMSOdYkogLtyUOU
SfKppLY20nEe269QhhDTyiosVQiLGzl9SIqY4gKSJ8qTzxeki5Jzu7nvBg1wtpso67aRUxFE59JU
teDC9H6671qkq9+emOMXm8QOcMchqR7cJwiruJ1ojtTmlH/z23XjUvm4bcP6Oiz4DGmf+0xlaw1P
KMnzMVMOiBPPq6a3jqNyY8YGUTwpXwwT0+yRll0TdHV5wdbJ9aRqUTo1dSvScwsJ0an9BgLsLb49
va6My+iKWfjiP/UdpFYYDwAA

--=-LfVyLD+vC1iAsXm+1qNz--
